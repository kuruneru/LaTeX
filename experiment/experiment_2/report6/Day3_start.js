document.addEventListener('DOMContentLoaded', function () {
  // HTMLからcanvas要素を取得する

  const r = 0.15; // 半径
  // canvas要素からwebglコンテキストを取得する
  const gl = canvas.getContext('webgl');

  // WebGLコンテキストが取得できたかどうか調べる
if (!gl) {
    alert('webgl not supported!');
    return;
  }

  // canvasを初期化する色を設定する
  gl.clearColor(0.0, 0.0, 0.0, 1.0);//RGBAの順で0--1の範囲

  // canvasを初期化する
  gl.clear(gl.COLOR_BUFFER_BIT);
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
    0.0, 0.2, 0.0,
    -0.3, -0.2, 0.0,
    0.3, -0.2, 0.0,
    0.025, -0.2, 0.0, 
    -0.025, -0.2, 0.0,
    0.025, -0.7, 0.0,
    -0.025, -0.2, 0.0,
    -0.025, -0.7, 0.0,
    0.025, -0.7, 0.0
  ];

  const circleVertexPosition = [
   0 , 0.35, 0.0
  ]
  const time = 60;
  for (let i = 0; i <= time; i++) {
    var rad = (i / time) * 2 * Math.PI;
    let x = Math.cos(rad) * r / (canvas.width / canvas.height);
    y = Math.sin(rad) * r + 0.35;
    circleVertexPosition.push(x, y , 0.0);
  }
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

  uGoldColor = gl.getUniformLocation(program, "uGlobalColor");
  gl.uniform4fv(uGoldColor, [0.0, 0.0, 1.0, 1.0]); 

  //三角形
  gl.drawArrays(gl.TRIANGLES, 0, 3); 
  gl.uniform4fv(uGoldColor, [0.0, 1.0, 0.0, 1.0]);
  gl.drawArrays(gl.TRIANGLES, 3, 3); 
  gl.uniform4fv(uGoldColor, [0.0, 1.0, 0.0, 1.0]);
  gl.drawArrays(gl.TRIANGLES, 6, 3); 

  //円
  gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(circleVertexPosition), gl.STATIC_DRAW);
  gl.uniform4fv(uGoldColor, [1.0, 0.0, 0.0, 1.0]);
  gl.drawArrays(gl.TRIANGLE_FAN, 0, circleVertexPosition.length / 3);
  gl.flush();

  });
