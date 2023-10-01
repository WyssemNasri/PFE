<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";

if (isset($post["cle"])) {
    $conn = mysqli_connect($servername, $username, $password, $dbname);

    if (!$conn) {
        die("Connexion échouée : " . mysqli_connect_error());
    }

    $cle = $post["cle"];
    $sql = "SELECT u.*, d.specialite, d.rate FROM users u LEFT JOIN doctors d ON u.cle = d.cle WHERE u.cle = '$cle'";
    $result = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $row,
        ]);
        exit;
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'fail',
            'data' => "utilisateur n'existe pas ",
        ]);
        exit;
    }
}
?>
