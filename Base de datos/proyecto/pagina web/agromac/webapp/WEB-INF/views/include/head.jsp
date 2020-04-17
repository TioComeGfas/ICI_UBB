<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<header class="main-header">
<spring:url value="/resources" var="urlPublic" />
<spring:url value="/" var ="urlRoot"></spring:url>
	<!-- Logo -->
	<a href="${urlRoot}home" class="logo">
		<span class="logo-mini"><b>A</b>dmin</span> 
		<span class="logo-lg"><b>Admi</b>nistrador</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top" role="navigation">
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<h3 class="text-center" style="font-weight: bold; color: white;">
			<i class="fas fa-tractor"></i>AGROMAQ
		</h3>
	</nav>
</header>
<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">

	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
			<!-- ACA DEBO CAMBIAR LA FOTO -->
				<img src="${urlPublic }/dist/img/profe.jpeg" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Maria Angelica Caro</p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> En Linea</a>
			</div>
		</div>
		
		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">MENÚ</li>

			<li class="treeview"><a href="#"><i class="fa fa-users"></i>
					<span>Cliente</span> <span class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${urlRoot}cliente/general"><i class="fas fa-clipboard-list"></i><span> Listar</span></a></li>
					<li><a href="${urlRoot}cliente/crear"><i class="fas fa-plus-circle"></i><span> Registrar</span></a></li>
					<!-- 
					<li><a href="${urlRoot}cliente/preferencial"><i class="fas fa-star"></i> <span>Preferencial</span></a></li>
					<li><a href="${urlRoot}cliente/regular"><i class="far fa-star"></i> <span>Regular</span></a></li>
					-->
				</ul></li>

			<li class="treeview"><a href="#"><i
					class="fas fa-user-secret"></i> <span>Empleado</span> <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${urlRoot}empleado/general"><i class="fas fa-clipboard-list"></i> <span>Listar</span></a></li>
					<li><a href="${urlRoot}empleado/crear"><i class="fas fa-plus-circle"></i> <span>Registrar</span></a></li>
					
					<!-- 
					<li><a href="${urlRoot}empleado/mecanico"><i class="fas fa-toolbox"></i> <span>Mecanico</span></a></li>
					<li><a href="${urlRoot}empleado/administrativo"><i class="fas fa-calculator"></i> <span>Administrador</span></a></li>
					<li><a href="${urlRoot}empleado/operador"><i class="fas fa-tachometer-alt"></i> <span>Operador</span></a></li>
					-->	
				</ul>
			</li>

			<li class="treeview"><a href="#"><i class="fas fa-hdd"></i>
					<span>Maquinaria</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${urlRoot}maquinaria/general"><i class="fas fa-clipboard-list"></i> <span>Listar</span></a></li>
					<li><a href="${urlRoot}maquinaria/crear"><i class="fas fa-plus-circle"></i> <span>Registrar</span></a></li>
					
					<!--  
					<li><a href="${urlRoot}maquinaria/tipo/general"><i class="fas fa-clipboard-list"></i> <span>Tipo</span></a></li>
					-->
				</ul></li>

			<li class="treeview"><a href="#"><i class="fas fa-wrench"></i>
					<span>Mantencion</span> <span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${urlRoot}mantencion/general"><i class="fas fa-screwdriver"></i> <span>Mantenciones</span></a></li>
					<li><a href="${urlRoot}mantencion/tipo"><i class="fas fa-clipboard-list"></i> <span>Tipo</span></a></li>
				</ul></li>
			
			<li class="treeview"><a href="#"><i class="fas fa-money-check-alt"></i>
					<span>Arriendo</span><span class="pull-right-container">
						<i class="fa fa-angle-left pull-right"></i>
				</span> </a>
				<ul class="treeview-menu">
					<li><a href="${urlRoot}arriendo/general"><i class="fas fa-clipboard-list"></i> <span>Listar</span></a></li>
					<li><a href="${urlRoot}arriendo/crear"><i class="fas fa-plus-circle"></i> <span>Registrar</span></a></li>
				</ul></li>

			<li><a href="${urlRoot}contrato/general"><i class="fas fa-file"></i> <span>Contratos</span></a></li>
			<li><a href="${urlRoot}consulta/geeneral"><i class="fas fa-file"></i> <span>Consultas</span></a></li>

		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>