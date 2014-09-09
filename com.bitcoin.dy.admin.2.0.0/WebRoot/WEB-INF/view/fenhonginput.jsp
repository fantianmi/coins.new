<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/head.jsp"%>
<!-- ****************后台管理系统******************** -->
<jsp:include page="/include/htmlsrc.jsp"></jsp:include>
<body>
<script type="text/javascript">
            function add(){
                document.getElementById('myForm').action = "bank.do?add";
                document.getElementById("myForm").submit();
            }
            
            function reject(){
                document.getElementById('myForm').action = "bank.do?reject";
                document.getElementById("myForm").submit();
            }
</script>
	<jsp:include page="/include/headhtml.jsp"></jsp:include>
	<jsp:include page="/include/lpanelhtml.jsp"></jsp:include>
    <div class="content">
        <jsp:include page="/include/pathpanelhtml.jsp"></jsp:include>
        <div class="workplace">
            <div class="row-fluid">
                <%
                String season = "";
                String poundageamount = "";
                String starttime = "";
                String endtime = "";
                if(request.getAttribute("season")!=null){
                	season = request.getAttribute("season").toString();
                }
                if(request.getAttribute("poundageamount")!=null){
                	poundageamount = request.getAttribute("poundageamount").toString();
                }
                if(request.getAttribute("starttime")!=null){
                	starttime = request.getAttribute("starttime").toString();
                }
                if(request.getAttribute("endtime")!=null){
                	endtime = request.getAttribute("endtime").toString();
                }
                %>
                <div class="span12">
                    <div class="head">
                        <div class="isw-documents"></div>
                        <h1>分红发放管理</h1>
                        <div class="clear"></div>
                    </div>
                    <div class="block-fluid">                        
                    <form action="fenhong.do?saveInput" method="post" id="fhinput">    
                    <input type="hidden" name="rate" id="rate" value="<%=request.getAttribute("rate").toString() %>"/>
                    <input type="hidden" name="season" id=season value="<%=season %>"/>
                        <div class="row-form">
                            <div class="span3"><span class="label label-important" style="font-size:16px; color:#FFF">第
                            <%=season %>期分红发放</span></div>
                            <div class="span9">
                            <span class="lead" style="font-size:12px">
                            您这一期的手续费收入为：
                            <span class="label label-important" style="font-size:16px; color:#FFF">
                            <%=poundageamount %>
                            </span>
                            &nbsp;元
                            <br>
                            请输入您这一期的将发放的总量，系统将会自动根据您的总量计算出这一期
                            每位分红用户应该得到的分红数量
                            </span>
                            </div>
                            <div class="clear"></div>
                        </div> 

                        <div class="row-form">
                            <div class="span3">
                            <span class="label label-important" style="font-size:16px; color:#FFF"><%=starttime %></span>
                            到
                            <span class="label label-important" style="font-size:16px; color:#FFF"><%=endtime %></span>
                            发放数量:</div>
                            <div class="span9">
                            <input type="text" style="width:200px" placeholder="精确到0.01" id="poundageamount" name="poundageamount">
                            <span class="label label-important" style="font-size:16px; color:#FFF">元</span>
                            </div>
                            <div class="clear"></div>
                        </div>                         
                        <div class="row-form">
                            <div class="span3"></div>
                            <div class="span9"><input value="确认" class="btn btn-large" type="button" onclick="submitForm('fhinput')"></div>
                            <div class="clear"></div>
                        </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>   
</body>
</html>
