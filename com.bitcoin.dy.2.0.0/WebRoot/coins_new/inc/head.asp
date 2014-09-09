<script type="text/javascript">
var isOver = 0;
function showSub(cur){
 for(i=1; i<=9; i++) {
  //加if判断防止由于疏忽遗漏ID或错定义ID导致脚本出错，下同
  if(document.getElementById("sub_"+[i]) != null){
   document.getElementById("sub_"+[i]).style.display='none';
  }
 }
 if(document.getElementById("sub_"+cur)!=null) {
  document.getElementById("sub_"+cur).style.display='block';
 }
 isOver = 1;
}
function isOut(){
 for(i=1; i<=9; i++) {
  if(document.getElementById("sub_"+[i]) != null && isOver == 0){
   document.getElementById("sub_"+[i]).style.display='none';
  }
 }
}
function hideSub(){
 isOver = 0;
 window.setTimeout("isOut()",1000); 
}
</script>

<div id="head">
  <div class="head">
    <div class="menu"><a href="#" onmouseover="showSub(1)" onmouseout="hideSub()"><img src="../img/meun.jpg" width="22" height="14" /></a></div>
    <div class="logo"><a href="index.asp"><img src="../img/logo.jpg" width="97" height="27" /></a></div>
  </div>
  <div class="menu_x">
    <div id="sub_1" onmouseover="showSub(1)" onmouseout="hideSub()" style="display:none;">
      <dl style="margin-left:0px;">
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl style="margin-left:0px;">
        <a href="bz_show.asp.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl style="margin-left:0px;">
        <a href="bz_show.asp.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
      <dl>
        <a href="bz_show.asp">
        <dt><img src="img/bbogo.jpg" width="40" height="40" /></dt>
        <dd>比利币(BIL)<br />
          <span style="color:#d80000;">CNY0.04</span><span style="color:#090;">(+0.00%)</span></dd>
        </a>
      </dl>
    </div>
  </div>
</div>
