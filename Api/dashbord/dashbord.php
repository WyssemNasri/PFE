<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
if(isset($post["nomPrenom"])) {
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
    }
    $cle =$post["nomPrenom"];
    $sql = "select * from users where nomPrenom = '$cle'";
    $result = mysqli_query($conn, $sql);
    $arrJson = array();
    if(mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
           $nomprenom=$row['nomPrenom'];
           $sql1= "SELECT 
            SUM(CASE WHEN status = 'refused' THEN 1 ELSE 0 END) AS refused_count,
            SUM(CASE WHEN status = 'accepted' THEN 1 ELSE 0 END) AS accepted_count,
            SUM(CASE WHEN status = 'waiting' THEN 1 ELSE 0 END) AS waiting_count
            FROM appointments where patient_name = '$nomprenom'";

            $result = mysqli_query($conn, $sql1);

            if (mysqli_num_rows($result) > 0) {
            $row1 = mysqli_fetch_assoc($result);

            http_response_code(200);
            echo json_encode([
            'code' => 'success',
            'data' => $row1]);
        exit ;
} else {
    http_response_code(400);
    echo json_encode([
        'code' => 'fail',
        'data' => "aucun rendez_vous compter"]);
        exit ;

}
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'fail',
            'data' => "inserer un nomPrenom"]);
            exit ;
    }
}