<php
<!DOCTYPE html>
<html>
<head>
	<title>Nouveau mot de passe</title>
	<style>
		body {
			font-family: Arial, sans-serif;
		}
		form {
			margin: 20px auto;
			width: 400px;
			padding: 20px;
			border: 2px solid #ccc;
			border-radius: 5px;
		}
		label {
			display: block;
			margin-bottom: 10px;
			font-weight: bold;
		}
		input[type="password"] {
			width: 95%;
			padding: 10px;
			margin-bottom: 20px;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 16px;
		}
		input[type="submit"] {
			background-color: #4CAF50;
			color: white;
			padding: 10px 20px;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			font-size: 16px;
		}
		input[type="submit"]:hover {
			background-color: #3e8e41;
		}
	</style>
</head>
<body>
	<form action="trait.php" method="get">  
	<label for="Cle">Votre cle:</label>
		<input type="password" id="cle" name="cle">
	<label for="password">Nouveau mot de passe :</label>
		<input type="password" id="password" name="password">
	<input type="submit" value="Enregistrer">
	</form>
</body>
</html>