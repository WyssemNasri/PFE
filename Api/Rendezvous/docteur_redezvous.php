<?php
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
    $conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
    $doctor_key = $post["nomPrenom"];
    $sql = "select nomPrenom from Users where nomPrenom = '$doctor_key'";
    $result1 = mysqli_query($conn, $sql);
    if(mysqli_num_rows($result1) == 1) {
        $row = mysqli_fetch_assoc($result1);
        $doctor_name=$row["nomPrenom"];
            $selectArray = array();
            array_push($selectArray, $doctor_name);
            $sql1 = "select * from appointments where doctor_name = ? and status = 'WAITING'";
            $result = dbExec($sql1, $selectArray);
            $arrJson = array();
            if ($result->rowCount() > 0) {
                $arrJson  = $result->fetchall();
                http_response_code(200);
                $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            } else {
                //bad request
                $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
                echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
            }
        }else {
            http_response_code(400);
      echo json_encode([
          'code' => 'fail',
          "message" => "empty",]);
          exit ;
      }


    

?>