<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
if (
    isset($post["email"])&& isset($post["password"])) {
    $conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
    $email = $post["email"];
    $password =$post["password"];
    $sql = "select * from Users where Email = '$email'and password ='$password'";
    $result = mysqli_query($conn, $sql);
    $arrJson = array();
    if(mysqli_num_rows($result) == 1) {
        $row = mysqli_fetch_assoc($result);
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $row]);
            exit ;
    } else {
          http_response_code(400);
    echo json_encode([
        'code' => 'fail',
        "message" => "empty"]);
        exit ;
    }
}else {
    http_response_code(400);
    echo json_encode([
        'code' => 'fail',
        "message" => "error",]);
        exit ;
}


