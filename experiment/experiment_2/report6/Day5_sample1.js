document.addEventListener('DOMContentLoaded', function () {
  // HTMLからcanvas要素を取得する
  const canvas = document.getElementById('canvas');
  canvas.width = 512;
  canvas.height = 512;
  
  // canvas要素からwebglコンテキストを取得する
  const gl = canvas.getContext('webgl');
  // WebGLコンテキストが取得できたかどうか調べる
  if (!gl) {
      alert('webgl not supported!');
      return;
  }

  // ------------ ここから追記 ------------
  program = glInitShader();

  setTimeout(render, 30);
  var frame = 0;
  //uniform変数の場所を取得
  var uMVLocation = gl.getUniformLocation(program, 'uMVMatrix');	//シェーダプログラム中のuPrMatrix変数の場所を受けとる
  var uPrLocation = gl.getUniformLocation(program, 'uPrMatrix');	//シェーダプログラム中のuMVMatrix変数の場所を受けとる
   
  MVMat = glMatrix.mat4.create();		//モデルビュー行列
  ModelMat = glMatrix.mat4.create(); 	//モデル行列
  ViewMat =  glMatrix.mat4.create();	//カメラ行列  
  PrMat = glMatrix.mat4.create(); 		//  投影行列
  let MVMatStack = [];
  
  let eye=glMatrix.vec3.fromValues(0,5,5);
  let center=glMatrix.vec3.fromValues(0,0,0);
  let up=glMatrix.vec3.fromValues(0,1,0);
  glMatrix.mat4.lookAt(ViewMat,eye,center,up);
  
  prMat = glMatrix.mat4.create();
  //glMatrix.mat4.identity(PrMat);
  glMatrix.mat4.perspective(PrMat,90.*Math.PI/180., canvas.width/canvas.height , 0.1, 10);
  //glMatrix.mat4.frustum(PrMat,-.5,.5,-.5,.5,0.05,2);
  
  // 6つの頂点の座標を定義する
  const triangleVertexPos = [
    0.0, 0.0, 0.0,
    -0.4, -2.8, 0.0,
    0.4, -2.8, 0.0,

    0.0, -0.0, 0.0,
    -0.4, 2.8, 0.0,
    0.4, 2.8, 0.0
	
  ];

  // 頂点バッファを作成する
  const triangleVertexBuffer = gl.createBuffer();
  // 頂点バッファをバインドする
  gl.bindBuffer(gl.ARRAY_BUFFER, triangleVertexBuffer);
  // 頂点バッファに頂点データをセットする
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(triangleVertexPos), gl.STATIC_DRAW);
 
  // Positionのロケーションを取得し、バッファを割り当てる
  const positionLocation = gl.getAttribLocation(program, 'position');
  gl.enableVertexAttribArray(positionLocation);
  gl.vertexAttribPointer(positionLocation, 3, gl.FLOAT, false, 0, 0);
 

  render();
  
	function render(){
	  gl.clearColor(0.0, 0.0, 0.0, 1.0);
	  gl.clear(gl.COLOR_BUFFER_BIT);

    glMatrix.mat4.identity(ModelMat);
    pushMVMatrix(); 
    glMatrix.mat4.translate(ModelMat, ModelMat, [2.0, 0.0, 0.0]);
    drawPiller();
    popMVMatrix();
    glMatrix.mat4.identity(ModelMat);
    pushMVMatrix();
    glMatrix.mat4.translate(ModelMat, ModelMat, [-2.0, 0.0, 0.0]);
    drawPiller();
    popMVMatrix();
  }
  
  function drawPiller() {
    for (let i = 0; i < 8; i++) {
      let localMat = glMatrix.mat4.clone(ModelMat);
      glMatrix.mat4.rotateY(localMat, localMat, (i * 360 / 8) * Math.PI / 180);  
      glMatrix.mat4.translate(localMat, localMat, [0.0, 0.0, 1]);
      glMatrix.mat4.multiply(MVMat,ViewMat,localMat);

      gl.uniformMatrix4fv(uMVLocation, false, MVMat)
      gl.uniformMatrix4fv(uPrLocation, false, PrMat)	//uPrLocationにPrMatの値を格納
        
      // 描画する
      gl.drawArrays(gl.TRIANGLES, 0, 6);
    }
	  gl.flush();
  }

  function pushMVMatrix() {
    var copyToPush = glMatrix.mat4.clone(MVMat);
    MVMatStack.push(copyToPush);
  }

  function popMVMatrix() {
    if (MVMatStack.length == 0) {
      throw "Error popMVMatrix()--stack was empty";
    }
    MVMat = MVMatStack.pop();
  }
	
	function glInitShader(){
	  // シェーダのソースを取得する
	  const vertexShaderSource = document.getElementById('vertexShader').textContent;
	  const fragmentShaderSource = document.getElementById('fragmentShader').textContent;

	  // シェーダをコンパイルして、プログラムオブジェクトにシェーダを割り当てる
	  const vertexShader = gl.createShader(gl.VERTEX_SHADER);
	  gl.shaderSource(vertexShader, vertexShaderSource);
	  gl.compileShader(vertexShader);
	  const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
	  gl.shaderSource(fragmentShader, fragmentShaderSource);
	  gl.compileShader(fragmentShader);

	  // プログラムオブジェクトにシェーダを作成する
	  const program = gl.createProgram();  
	  gl.attachShader(program, vertexShader);
	  gl.attachShader(program, fragmentShader);
	  gl.linkProgram(program);

	  // プログラムオブジェクトを有効にする
	  gl.useProgram(program);
	  return program
	}

});


