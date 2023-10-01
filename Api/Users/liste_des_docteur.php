<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";
$privilege="medecin";
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
$selectArray=array();
array_push($selectArray,$privilege);
$sql="SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
FROM users
INNER JOIN doctors
on users.cle=doctors.cle
WHERE  privilege = ?";
$result=dbExec($sql,$selectArray);
$arrJson = array();
if ($result->rowCount() > 0) {
    $arrJson  = $result->fetchall();
    http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $arrJson]);
            exit ;
} else {    
    http_response_code(400);
        echo json_encode([
            'code' => 'faild',
            'data' => "eurror"]);
            exit ;
}

