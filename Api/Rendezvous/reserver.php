<?php
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
include_once "../library/function.php";

$patient_key=$post["patient_key"];
$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
$sql = "select * from users where cle = '$patient_key'";
$result1 = mysqli_query($conn, $sql);
if(mysqli_num_rows($result1) == 1) {
    $row = mysqli_fetch_assoc($result1);
    $patient_name=$row["nomPrenom"];
    $medecin = $post["doctor_name"];
    $date = $post["date"];
    $heure = $post["time"];

    $selectArray = array();
    array_push($selectArray, $medecin);
    array_push($selectArray, $patient_name);
    array_push($selectArray, $date);
    array_push($selectArray, $heure);

    $sql = "insert into appointments
        (doctor_name ,patient_name , date , time
        )
            values(? , ? , ? , ? 
            )";
    $result = dbExec($sql, $selectArray);
    $arrJson = array();
    if ($result->rowCount() > 0) {
        $arrJson  = $result->fetchall();
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {$resJson = array("result" => "failed", "code" => "400", "message" => "failed");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }}
    else{
        $resJson = array("result" => "failed", "code" => "400", "message" => "done");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
 

?>