<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";
$privilege="patient";
$privilege1="medecin";
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
array_push($selectArray,$privilege1);
$sql="SELECT nomprenom from users where privilege = ? or privilege = ?";
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
