<?php
include_once "database.php";
function dbExec($sql, $param_array)
{
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $stmt = $myCon->prepare($sql);
    $stmt->execute($param_array);
    return $stmt;
}
function updateTable()
{
    $servername = "localhost"; // Nom du serveur MySQL
$username = "root"; // Nom d'utilisateur MySQL
$password = ""; // Mot de passe MySQL
$dbname = "petmad"; // Nom de la base de données

$conn = mysqli_connect($servername, $username, $password, $dbname);

// Vérifie la connexion
if (!$conn) {
    die("La connexion a échoué: " . mysqli_connect_error());
}

// Supprime les lignes de la table 'ma_table' où la date est inférieure à la date actuelle moins un jour
$date = date('Y-m-d', strtotime('-1 day')); // Calcule la date d'il y a un jour
$sql = "DELETE FROM ma_trendezvous  WHERE date < '$date'";

mysqli_query($conn, $sql);
mysqli_close($conn);
}
