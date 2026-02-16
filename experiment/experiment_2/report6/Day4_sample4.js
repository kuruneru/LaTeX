document.addEventListener('DOMContentLoaded', function () {
  // HTMLからcanvas要素を取得する
  const canvas = document.getElementById('canvas');

  // canvas要素からwebglコンテキストを取得する
  const gl = canvas.getContext('webgl');

  // WebGLコンテキストが取得できたかどうか調べる
  if (!gl) {
      alert('webgl not supported!');
      return;
  }

  setTimeout(render, 30);
  var frame = 0;
  function render() {
  // canvasを初期化する色を設定する
  gl.clearColor(0.0, 0.0, 0.0, 1.0);

  // canvasを初期化する
  gl.clear(gl.COLOR_BUFFER_BIT);
  frame++;
  // ------------ ここから追記 ------------
  // プログラムオブジェクトを作成する
  const program = gl.createProgram();  

  // シェーダのソースを取得する
  const vertexShaderSource = document.getElementById('vertexShader').textContent;
  const fragmentShaderSource = document.getElementById('fragmentShader').textContent;

  // シェーダをコンパイルして、プログラムオブジェクトにシェーダを割り当てる
  const vertexShader = gl.createShader(gl.VERTEX_SHADER);
  gl.shaderSource(vertexShader, vertexShaderSource);
  gl.compileShader(vertexShader);
  gl.attachShader(program, vertexShader);
  const fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
  gl.shaderSource(fragmentShader, fragmentShaderSource);
  gl.compileShader(fragmentShader);
  gl.attachShader(program, fragmentShader);

  // シェーダをリンクする
  gl.linkProgram(program);
  // プログラムオブジェクトを有効にする
  gl.useProgram(program);

  // 3つの頂点の座標を定義する
  const triangleVertexPosition = [
    0.0, 0.4, 0.0,
    -0.4, -0.4, 0.0,
    0.4, -0.4, 0.0
  ];

  // 頂点バッファを作成する
  const triangleVertexBuffer = gl.createBuffer();
  // 頂点バッファをバインドする
  gl.bindBuffer(gl.ARRAY_BUFFER, triangleVertexBuffer);
  // 頂点バッファに頂点データをセットする
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(triangleVertexPosition), gl.STATIC_DRAW);
  
  // Positionのロケーションを取得し、バッファを割り当てる
  const positionLocation = gl.getAttribLocation(program, 'position');
  gl.enableVertexAttribArray(positionLocation);
  gl.vertexAttribPointer(positionLocation, 3, gl.FLOAT, false, 0, 0);

  MVMat = glMatrix.mat4.create();
  glMatrix.mat4.identity(MVMat);
  glMatrix.mat4.rotateX(MVMat, MVMat, 3.14/180.*frame);  
  glMatrix.mat4.translate(MVMat, MVMat, [0.4, 0.2, -.2]);
  let eye=glMatrix.vec3.fromValues(0,0,3);
  let center=glMatrix.vec3.fromValues(0,0,0);
  let up=glMatrix.vec3.fromValues(0,1,0);
  var lookAtMatrix = glMatrix.mat4.create();
  glMatrix.mat4.lookAt(lookAtMatrix,eye,center,up);
  console.log(lookAtMatrix)
  glMatrix.mat4.multiply(MVMat,lookAtMatrix,MVMat);
  
	//uPrLocationにMVMatの値を格納	
  PrMat = glMatrix.mat4.create();
  //glMatrix.mat4.identity(PrMat);
  glMatrix.mat4.perspective(PrMat,.4*Math.PI,1,0.1,3);


  //glMatrix.mat4.frustum(PrMat,-.5,.5,-.5,.5,0.05,2);
  //console.log(PrMat)
  var uPrLocation = gl.getUniformLocation(program, 'uPrMatrix');
	//シェーダプログラム中のuPrMatrix変数の場所を受けとる
  gl.uniformMatrix4fv(uPrLocation, false, PrMat)
	//uPrLocationにPrMatの値を格納
  var uMVLocation = gl.getUniformLocation(program, 'uMVMatrix');
	//シェーダプログラム中のuMVMatrix変数の場所を受けとる
  gl.uniformMatrix4fv(uMVLocation, false, MVMat)

	
  // 描画する
  gl.drawArrays(gl.TRIANGLES, 0, 3);

  gl.flush();
  setTimeout(render, 30);
  }
  // ------------ ここまで追記 ------------
});
