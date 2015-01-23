<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="differential.Differential" %>
 <%@ page import="java.text.DecimalFormat;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数値微分</title>
<style type="text/css">
	body { background-color:#f0f0ff }
	.tbl { border-style:solid; border-width:1px;border-color:darkgreen;border-collapse:collapse; width:1200px }
	.dt_o { border-style:solid; border-width:1px; border-color:darkgreen }
	.dt_e { border-style:solid; border-width:1px; border-color:darkgreen;background-color:#c0c0ff }
	.head { border-style:solid; border-width:1px; border-color:darkgreen;background-color:darkgreen;color:white }
</style>

<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart1);
      google.setOnLoadCallback(drawChart2);
      google.setOnLoadCallback(drawChart3);
      
      function drawChart1() {
        var data1 = google.visualization.arrayToDataTable([
			['hの値', '数値微分(定義式)','中心差分公式', '理論値'],
                                                          
	<%
	DecimalFormat dcf = new DecimalFormat("0.00E0");
	Differential dif1 = (Differential)request.getAttribute( "res" );
	double df1[] = dif1.getDf();
	double cdf1[] = dif1.getCdf();
	for(int i = 0; i < df1.length; i++){
		 if(i == df1.length-1){
			 %> 
			 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=df1[i]%>, <%=cdf1[i]%>, 0.500]
			 <%
		 }else{
		 %> 
		 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=df1[i]%> , <%=cdf1[i]%>, 0.500],
		 <%
		 }
		
	}
	
	%>
        ]);

        var options1 = {
          title: '数値微分：hの値による変動'
        };

        var chart1 = new google.visualization.LineChart(document.getElementById('chart_div1'));

        chart1.draw(data1, options1);
      }
      
      function drawChart2() {
          var data2 = google.visualization.arrayToDataTable([
  			['hの値', '絶対誤差(定義式)','中心差分公式'],
                                                            
  	<%
  	for(int i = 0; i < df1.length; i++){
  		 if(i == df1.length-1){
  			 %> 
  			 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=Math.log10(Math.abs(0.500 - df1[i]))%>,<%=Math.log10(Math.abs(0.500 - cdf1[i]))%>]
  			 <%
  		 }else{
  		 %> 
  		 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=Math.log10(Math.abs(0.500 - df1[i]))%>,<%=Math.log10(Math.abs(0.500 - cdf1[i]))%>],
  		 <%
  		 }
  		
  	}
  	
  	%>
          ]);

          var options2 = {
            title: '数値微分：hの値による変動(絶対誤差:対数表記)'
          };

          var chart2 = new google.visualization.LineChart(document.getElementById('chart_div2'));

          chart2.draw(data2, options2);
        }
      
      function drawChart3() {
          var data3 = google.visualization.arrayToDataTable([
  			['hの値', '相対誤差(対数表記)%'],
                                                            
  	<%
  	for(int i = 0; i < df1.length; i++){
  		 if(i == df1.length-1){
  			 %> 
  			 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=Math.log10(Math.abs(0.500 - df1[i])/0.500*100)%>]
  			 <%
  		 }else{
  		 %> 
  		 ['<%= dcf.format(Math.pow(0.1, i + 1)) %>',<%=Math.log10(Math.abs(0.500 - df1[i])/0.500)*100%>],
  		 <%
  		 }
  		
  	}
  	
  	%>
          ]);

          var options3 = {
            title: '数値微分：hの値による変動(相対誤差%:対数表記)'
          };

          var chart3 = new google.visualization.LineChart(document.getElementById('chart_div3'));

          chart3.draw(data3, options3);
        }
      
    </script>


</head>
<body>
<h2 style='text-align:center'>数値微分</h2>
<hr/>
<a href="/index.html">メインへ</a>

<br>
[設定値]
<table class='tbl'>
<tr>
<th class='head'>対象関数f(x)</th><th class='head'>微分関数f'(x)</th><th class='head'>微分点a</th><th class='head'>微分理論値f'(a)</th><th class='head'>h : 初期値</th><th class='head'>h : 最終値</th>
</tr>

<% 
	int cnt = 0;
	int index = dif1.getIndex();
%>

<% String cls = "dt_e"; %>
	<tr>
	<td class='<%=cls%>' width='120' style='text-align:center'>f(x) = sinx</td>
	<td class='<%=cls%>' width='120' style='text-align:center'>f'(x) = cosx</td>
	<td class='<%=cls%>' width='120' style='text-align:center'>a = PI/3</td>
	<td class='<%=cls%>' width='120' style='text-align:center'>f'(a) = 0.500</td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=dcf.format(0.1)%></td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=dcf.format(Math.pow(0.1,12))%></td>
	</tr>
</table>

<br>
<br>
<br>
[結果]
<table class='tbl'>
<tr>
<th class='head'>数値微分法</th><th class='head'>微分(理論値)</th><th class='head'>数値微分(最良値)</th><th class='head'>相対誤差%(最良値)</th><th class='head'>最良のhの値</th>
</tr>


	<tr>
	<td class='<%=cls%>' width='120' style='text-align:center'>定義式利用</td>
	<td class='<%=cls%>' width='120' style='text-align:center'>0.500</td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=df1[index]%></td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=Math.abs((df1[index] - 0.500)/0.500)*100%></td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=dcf.format(Math.pow(0.1, index + 1))%></td>
	</tr>
	
	<% cls = "dt_o"; %>
	
</table>

<br>
<div id="chart_div1" style="width: 1000px; height: 500px;"></div>
<br>
<div id="chart_div2" style="width: 1000px; height: 500px;"></div>
<br>
<div id="chart_div3" style="width: 1000px; height: 500px;"></div>
<br>
[計算ログ]
<table class='tbl'>
<tr>
<th class='head'>数値微分法</th><th class='head' ">hの値</th><th class='head'>微分(理論値)</th><th class='head'>数値微分</th><th class='head'>絶対誤差</th><th class='head'>相対誤差%</th>
</tr>

<%
		for(int i = 0; i < df1.length; i++){
			if ((cnt % 2) == 0) {
				cls = "dt_e";
			} else {
				cls = "dt_o";
			}%>

	<tr>
	<td class='<%=cls%>' width='200' style='text-align:center'>定義式利用</td>
	<td class='<%=cls%>' width='120' style='text-align:center'><%=dcf.format(Math.pow(0.1, i + 1))%></td>
	<td class='<%=cls%>' width='200' style='text-align:center'><%=0.500%></td>
	<td class='<%=cls%>' width='200' style='text-align:center'><%=df1[i]%></td>
	<td class='<%=cls%>' width='400' style='text-align:center'><%=Math.abs(df1[i] - 0.500)%></td>
	<td class='<%=cls%>' width='400' style='text-align:center'><%=Math.abs(df1[i] - 0.500)/0.500 *100%></td>
	</tr>
	
	<%
		cnt++;

   }%>


</body>
</html>