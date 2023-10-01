<?php 
$post = json_decode(file_get_contents('php://input'), true);
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$new_password= $_GET["password"];
$key= $_GET["cle"];
$connexion = mysqli_connect("localhost", "root","", "promedplus");
if (!$connexion) {
    die("La connexion à la base de données a échoué : " . mysqli_connect_error());
  }
  
  // affichage d'un message en cas de connexion réussie
  echo "Connexion à la base de données réussie !";
$sql = "UPDATE users SET password = '$new_password' WHERE cle = '$key'";
$resultat = mysqli_query($connexion,$sql);
if (!$resultat) {
    die("La requête UPDATE a échoué : " . mysqli_error($connexion));
  }
  
  // affichage d'un message de confirmation
  echo "Le mot de passe a été mis à jour avec succès !";
  
  // fermeture de la connexion à la base de données
  mysqli_close($connexion);
?>