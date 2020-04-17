<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>AGROMAQ</title>
<spring:url value="/resources" var="urlPublic" />
<spring:url value="/" var="urlRoot"/>
<spring:url value="/contrato/save" var="urlSave"/>

<!-- Tell the browser to be responsive to screen width -->
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
<link rel="stylesheet"
	href="${urlPublic }/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet"
	href="${urlPublic }/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${urlPublic }/dist/css/AdminLTE.min.css">
<!-- Icon Style -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="${urlPublic }/dist/css/skins/skin-blue.min.css">

<!-- Google Font -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">

	<!-- fragmento de barra lateral y barra superior -->
	<jsp:include page="../include/head.jsp"></jsp:include>

	<div class="content-wrapper">
		<section class="content-header">
			
			<!-- muestra los errores al usuario -->
			<spring:hasBindErrors name="encargado">
				<div class='alert alert-danger' role='alert'>
					Por favor corrija los siguientes errores:
					<ul>
						<c:forEach var="error" items="${errors.allErrors}">
							<li><spring:message message="${error}" /></li>
						</c:forEach>
					</ul>
				</div>
			</spring:hasBindErrors>
			
		</section>

		<section class="content">
			<div class="box box-solid box-success">
				<div class="box-header with-border">
					<h3 class="box-title">
						<b>Contrato</b>
					</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-success">
							<i class="fas fa-backspace"></i> Limpiar
						</button>
					</div>
				</div>
				<!-- /.box-header -->

				<form:form action="${urlSave}" method="POST" modelAttribute="contrato">
					
					<form:hidden path="id"/>
					
					<div class="box-body">

						<span class="badge bg-navy">Datos Relevantes</span>

						<div class="form-group">
							<br /> 
							<label for="inputfinicio" class="col-sm-2 control-label">Inicio</label>

							<div class="col-sm-10">
								<form:input path="fechaInicio" value="${contrato.fechaInicio}" type="date" class="form-control"
									id="inputfinicio" />
							</div>
						</div>
						
						<div class="form-group">
							<br /> 
							<label for="inputffin" class="col-sm-2 control-label">Termino</label>

							<div class="col-sm-10">
								<form:input path="fechaFin" value="${contrato.fechaFin }" type="date" class="form-control"
									id="inputffin" />
							</div>
						</div>
						
						<div class="form-group">
							<br /> 
							<label for="inputsalario" class="col-sm-2 control-label">Salario</label>

							<div class="col-sm-10">
								<form:input path="salario" value="${contrato.salario }" type="number" class="form-control"
									id="inputsalario" />
							</div>
						</div>

					</div>
					<!-- /.box-body -->

					<div class="box-footer">
						<a href="${urlRoot}contrato/general" role="button"
							class="btn btn-large btn-default">Volver</a>
						<button type="submit" class="btn btn-success pull-right">Guardar</button>
					</div>
					<!-- box-footer -->
				</form:form>


			</div>
		</section>
	</div>

	<!-- fragmento de footer -->
	<jsp:include page="../include/footer.jsp"></jsp:include>

	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->

	<!-- jQuery 3 -->
	<script src="${urlPublic }/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap 3.3.7 -->
	<script
		src="${urlPublic }/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${urlPublic }/dist/js/adminlte.min.js"></script>

</body>
</html>