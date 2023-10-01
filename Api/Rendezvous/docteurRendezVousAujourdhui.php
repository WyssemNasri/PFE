<?php
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
$conn = mysqli_connect($servername, $username, $password, $dbname);

$docteur_key = $post["nomPrenom"];
$sql = "SELECT * FROM Users WHERE nomPrenom = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $docteur_key);
$stmt->execute();
$result1 = $stmt->get_result();

if (mysqli_num_rows($result1) == 1) {
    $row = mysqli_fetch_assoc($result1);
    $docteur_name = $row["nomPrenom"];

    $today = date('Y-m-d'); // Obtenir la date d'aujourd'hui

    $sql1 = "SELECT * FROM appointments WHERE doctor_name = ? AND status = 'accepted' AND date = ?";
    $stmt = $conn->prepare($sql1);
    $stmt->bind_param("ss", $docteur_name, $today);
    $stmt->execute();
    $result = $stmt->get_result();

    $arrJson = array();

    if ($result->num_rows > 0) {
        $arrJson = $result->fetch_all(MYSQLI_ASSOC);
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        // Aucun rendez-vous trouvé pour aujourd'hui
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun rendez-vous pour aujourd'hui");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
} else {
    // Clé du docteur non trouvée
    http_response_code(400);
    echo json_encode([
        'code' => 'fail',
        "message" => "empty",
    ]);
    exit;
}
?>
