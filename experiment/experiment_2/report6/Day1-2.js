window.onload = function() {
    // 全てのtdタグを取得
    var cells = document.getElementsByTagName("td");
    
    // ループでイベントを設定
    for (var i = 0; i < cells.length; i++) {
        cells[i].onclick = function() {
            var val = document.getElementById("input_text").value;
            if (val == "") return;

            // div要素を作り、テキストを入れて、セルに追加(appendChild)する
            var div = document.createElement("div");
            div.appendChild(document.createTextNode(val));
            this.appendChild(div);
        };
    }
};
