<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
if(isset($post['nomPrenom']))
{
    $nomPrenom=$post['nomPrenom'];
    $conn = mysqli_connect("localhost", "root", "", "promedplus");
    $sql = "select * from diagnostics where nomPrenom = '$nomPrenom'";
    $result = mysqli_query($conn, $sql);
    if(mysqli_num_rows($result) == 1) {
        $row = mysqli_fetch_assoc($result);
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $row]);
            exit ;
        }
    else{
        http_response_code(200);
        echo json_encode([
            'code' => 'fail',
            'data' => "le nomPrenom de L'utilisateur n'existe pas !  "]);
            exit ;
    }
    }
else {
        http_response_code(400);
  echo json_encode([
      'code' => 'fail',
      "message" => "Merci de Taper votre clé"]);
      exit ;
  }