<!-- 환경설정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="/js/admin_setting.js"></script>
<script type="text/javascript">
	$(function() {
		var Accordion = function(el, multiple) {
			this.el = el || {};
			this.multiple = multiple || false;
			
			var dropdownlink = this.el.find('.dropdownlink');
			dropdownlink.on('click',
					{ el: this.el, multiple: this.multiple },
					this.dropdown);
			};
			Accordion.prototype.dropdown = function(e) {
				var $el = e.data.el,
				$this = $(this),
				$next = $this.next();
				$next.slideToggle();
				$this.parent().toggleClass('open');
				$('.setting_text').text($this.text());
				
				if(!e.data.multiple) {
					$el.find('.submenuItems').not($next).slideUp().parent().removeClass('open');
				}
			}
			var accordion = new Accordion($('.accordion-menu'), false);
			
			$(".submenuItems li a").click(function(event){
				$(".submenuItems li a").removeClass("selected");
				$(event.target).addClass("selected");
			});
			
			$('.dropdownlink')[0].click();
			$(".submenuItems li a#user1").addClass("selected");
		});
</script>
<div class="cont_area">
	<div class="cont_area_west">
		<div class="menu_area">
			<ul class="accordion-menu">
				<li>
					<div class="dropdownlink">
						<span class="dropdownlink_set"></span>
						사용자관리
						<span class="dropdownlink_btn"></span>
					</div>
					<ul class="submenuItems">
						<li><a href="javascript:changeSubmenu('user1')" id="user1">사용자관리</a></li>
						<!-- <li><a href="javascript:changeSubmenu('user2')" id="user2">지역별 사용자</a></li> -->
					</ul>
				</li>
				<li>
					<div class="dropdownlink">
						<span class="dropdownlink_set"></span>
						그룹관리
						<span class="dropdownlink_btn"></span>
					</div>
					<ul class="submenuItems">
						<li><a href="javascript:changeSubmenu('group1')" id="group1">그룹관리</a></li>
						<li><a href="javascript:changeSubmenu('group2')" id="group2">그룹별 이벤트 (사용자권한)</a></li>
						<li><a href="javascript:changeSubmenu('group3')" id="group3">그룹별 사용자조회</a></li>
						<li><a href="javascript:changeSubmenu('group4')" id="group4">그룹별 권한레벨관리</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<div class="cont_area_center">
		<div class="center_cont" id="user1_cont">
		    <jsp:include page="admin_setting_user1.jsp"/>
		</div>
		<%-- <div class="center_cont" id="user2_cont">
		    <jsp:include page="admin_setting_user2.jsp"/>
		</div> --%>
		<div class="center_cont" id="group1_cont">
		    <jsp:include page="admin_setting_group1.jsp"/>
		</div>
		<div class="half_cont" id="group2_cont">
		    <jsp:include page="admin_setting_group2.jsp"/>
		</div>
		<div class="half_cont" id="group3_cont">
		    <jsp:include page="admin_setting_group3.jsp"/>
		</div>
		<div class="half_cont" id="group4_cont">
		    <jsp:include page="admin_setting_group4.jsp"/>
		</div>
	</div>
</div>


