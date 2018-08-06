<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>

<link type="text/css" rel="stylesheet" href="./css/gis_print.css?ver=1">
<!-- <link type="text/css" rel="stylesheet" href="./css/print/import.css"> -->
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/print/printLeft.js" charset="UTF-8"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	var pos_x = <%=request.getParameter("pos_x")%>;
        var pos_y = <%=request.getParameter("pos_y")%>;
        var zoom = <%=request.getParameter("zoom")%>;
    	
        $("#printMain").attr("src","printMapPage.do?&pos_x="+pos_x+"&pos_y="+pos_y+"&zoom="+zoom);
    });
</script>
</head>
<body>
<!--  <OBJECT ID="cDialog1" WIDTH="0px" HEIGHT="0px" CLASSID="CLSID:F9043C85-F6F2-101A-A3C9-08002B2F49FB" CODEBASE="lib/comdlg32.cab"></OBJECT> -->
<div class="popup">
	<div class="popup_contents w918">
		<div class="input_box" style="height:577px; width:232px;">
			<div class="box2">
				<!-- <h2><img src="./images/print/map_input_tit.png" alt="����" /></h2> -->
				<h2><span class="left_title">����</span></h2>
				<ul class="cont">
					<li>
						<span>����</span>
						<input type="text" class="w180 txt" id="title" name="input" value="������� ����"/>
					</li>
					<li>
						<span>�۾�ü</span>
						<select name="select" id="title_font" class="w180">
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="�ü�">�ü�</option>
							<option value="�ü�ü">�ü�ü</option>
						</select>
					</li>
					<li>
						<span>ũ��</span>
						<select name="select" id="title_size" class="w60">
							<option value="����">9px</option>
							<option value="12px">12px</option>
							<option value="15px">15px</option>
							<option value="18px" selected>18px</option>
							<option value="24px">24px</option>
							<option value="36px">36px</option>
							<option value="48px">48px</option>
							<option value="60px">60px</option>
							<option value="72px">72px</option>
							<option value="84px">84px</option>
							<option value="96px">96px</option>
							<option value="108px">108px</option>
							<option value="120px">120px</option>
						</select>
						<!-- <input id="txtTColor" name="txtTColor" type="text" class="fontColor" style="width:12px;height:12px;" onFocus="blur();" onClick="OpenColorTable('t');" onMouseOver="this.style.cursor='hand';" value="��">
						<div style="position:absolute;width:160px;height:135px;display:none;overflow:hidden;" id="tColorTable">
							<iframe id='tColorTableFrame' name='tColorTableFrame' src='ColorTable.htm' border='0' scrolling='no' style='width:160px; height:135px; border-style:none;' onMouseOut="closeLayers()"></iframe>
						</div> -->
					</li>
					<li>
						<span>ȿ��</span>
						<input type="checkbox"  name="checkbox_B" id="title_bold" class="chk chk_margin" />
						<label for="checkbox_B" class="bold f11">��</label>
						<input type="checkbox"  name="checkbox_I" id="title_italic" class="chk" />
						<label for="checkbox_I" class="italc f11 mgr_2">��</label>
						<input type="checkbox"  name="checkbox_U" id="title_underline" class="chk" />
						<label for="checkbox_U" class="underline f11">��</label>
					</li>
				</ul>
			</div>
			<div class="box2">
				<!-- <h2><img src="./images/print/map_input_position.png" alt="��ġ" /></h2> -->
				<h2><span class="left_title">���ּ�</span></h2>
				<ul class="cont">
					<li>
						<span>�ּ�</span>
						<!-- <input type="text" class="w180 txt" id="position" name="input" /> -->
						<textarea name="textarea" id="position" cols="50" rows="30"></textarea>
					</li>
					<li>
						<span>�۾�ü</span>
						<select name="select" id="position_font" class="w180">
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="�ü�">�ü�</option>
							<option value="�ü�ü">�ü�ü</option>
						</select>
					</li>
					<li>
						<span>ũ��</span>
						<select name="select" id="position_size" class="w60">
							<option value="����">9px</option>
							<option value="12px">12px</option>
							<option value="15px" selected>15px</option>
							<option value="18px">18px</option>
							<option value="24px">24px</option>
							<option value="36px">36px</option>
							<option value="48px">48px</option>
							<option value="60px">60px</option>
							<option value="72px">72px</option>
							<option value="84px">84px</option>
							<option value="96px">96px</option>
							<option value="108px">108px</option>
							<option value="120px">120px</option>
						</select>
						<!-- <input id="txtPColor" name="txtPColor" type="text" class="fontColor" style="width:12px;height:12px;" onFocus="blur();" onClick="OpenColorTable('p');" onMouseOver="this.style.cursor='hand';" value="��">
						<div style="position:absolute;width:160px;height:135px;display:none;overflow:hidden;" id="pColorTable">
							<iframe id='pColorTableFrame' name='pColorTableFrame' src='ColorTable.htm' border='0' scrolling='no' style='width:160px; height:135px; border-style:none;' onMouseOut="closeLayers()"></iframe>
						</div> -->
					</li>
					<li>
						<span>ȿ��</span>
						<input type="checkbox"  name="checkbox_B" id="position_bold" class="chk chk_margin" />
						<label for="checkbox_B" class="bold f11">��</label>
						<input type="checkbox"  name="checkbox_I" id="position_italic" class="chk" />
						<label for="checkbox_I" class="italc f11 mgr_2">��</label>
						<input type="checkbox"  name="checkbox_U" id="position_underline" class="chk" />
						<label for="checkbox_U" class="underline f11">��</label>
					</li>
				</ul>
			</div>
			<div class="box2">
				<!-- <h2><img src="./images/print/map_input_cont.png" alt="����" /></h2> -->
				<h2><span class="left_title">����</span></h2>
				<ul class="cont">
					<li>
						<span>����</span>
						<textarea name="textarea" id="contents" cols="50" rows="30"></textarea>
					</li>
					<li>
						<span>�۾�ü</span>
						<select name="select" id="content_font" class="w180">
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="����">����</option>
							<option value="����ü">����ü</option>
							<option value="�ü�">�ü�</option>
							<option value="�ü�ü">�ü�ü</option>
						</select>
					</li>
					<li>
						<span>ũ��</span>
						<select name="select" id="content_size" class="w60">
							<option value="9px">9px</option>
							<option value="12px">12px</option>
							<option value="15px">15px</option>
							<option value="18px" selected>18px</option>
							<option value="24px">24px</option>
							<option value="36px">36px</option>
							<option value="48px">48px</option>
							<option value="60px">60px</option>
							<option value="72px">72px</option>
							<option value="84px">84px</option>
							<option value="96px">96px</option>
							<option value="108px">108px</option>
							<option value="120px">120px</option>
						</select>
						<!-- <input id="txtCColor" name="txtCColor" type="text" class="fontColor" style="width:12px;height:12px;" onFocus="blur();" onClick="OpenColorTable('c');" onMouseOver="this.style.cursor='hand';" value="��">
						<div style="position:absolute;width:160px;height:135px;display:none;overflow:hidden;" id="cColorTable">
							<iframe id='cColorTableFrame' name='cColorTableFrame' src='ColorTable.htm' border='0' scrolling='no' style='width:160px; height:135px; border-style:none;' onMouseOut="closeLayers()"></iframe>
						</div> -->
					</li>
					<li>
						<span>ȿ��</span>
						<input type="checkbox"  name="checkbox_B" id="content_bold" class="chk chk_margin" />
						<label for="checkbox_B" class="bold f11">��</label>
						<input type="checkbox"  name="checkbox_I" id="content_italic" class="chk" />
						<label for="checkbox_I" class="italc f11 mgr_2">��</label>
						<input type="checkbox"  name="checkbox_U" id="content_underline" class="chk" />
						<label for="checkbox_U" class="underline f11">��</label>
					</li>
				</ul>
			</div>
			<div class="print-toolbar">
				<a href="#" class="easyui-linkbutton" onClick="onUpdate()">�����ϱ�</a>
				<a href="#" class="easyui-linkbutton" onClick="printMain.Print_Preview(7);">�μ��ϱ�</a>
			</div>
			
			<!-- <input type="image" src="./images/print/btn_applycation.png" alt="�����ϱ�" class="apply" onclick="onUpdate()"/>
			<input type="image" src="./images/print/btn_print.png" alt="�μ��ϱ�" class="print" onclick="printMain.Print_Preview(7);"/> -->
			
			<!-- <input type="image" src="./images/print/btn_applycation.png" alt="�����ϱ�" class="apply" onclick="onUpdate()"/>
			<div class="print_area">
				<div class="print_box">
					<ul>
						<li>
							<span>����ũ�⼳��</span>
							<select name="select2" id="ptype" class="w145" onchange="OnChangePrintSizse()">
								<option value="A4" selected>A4</option>
								<option value="A3">A3</option>
							</select>
						</li>
						<li>
							<span>�μ⼳��</span>
							<input id="setupPaper" type="image" src="./images/print/btn_paper.png" alt="��������"  onclick="printMain.Print_Preview(8);" disabled="disabled"/>
							<p class="comment">*  ����ũ�⼳���� ���� ũ��� ��������<br />
							�˾�â�� ���� ũ�⸦ �����ϰ� ������ ��<br />
							����Ͻñ� �ٶ��ϴ�. </p>
						</li>
					</ul>
				</div>
				<input type="image" src="./images/print/btn_print.png" alt="�μ��ϱ�" class="print" onclick="printMain.Print_Preview(7);"/>
			</div> -->
		</div>
		<iframe id="printMain" name="printMain" src="#" frameborder="0" scrolling="auto" style="width:898px; height:577px;"></iframe>
	</div>
</div>
</body>
</html>