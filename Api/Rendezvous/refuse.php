<?php
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
$id_rendez_vous = $post["id"];
$sql = "UPDATE `appointments` SET `status` = 'refused' WHERE `id` = ?";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_bind_param($stmt, "i", $id_rendez_vous);
$result = mysqli_stmt_execute($stmt);
if ($result) {
    http_response_code(200);
    echo json_encode([
        'result' => 'success',
        'message' => 'empty',
    ]);
} else {
    http_response_code(400);
    echo json_encode([
        'result' => 'error',
        'message' => 'Failed to update status',
    ]);
}
?>
