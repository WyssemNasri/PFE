<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";

$conn = mysqli_connect($servername, $username, $password, $dbname);

// Vérification de la connexion
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

// Récupération des données du formulaire
$patient_key = $post["patient_key"];

// Requête SQL pour récupérer les données actuelles du patient
$sql_select = "SELECT * FROM diagnostics WHERE patient_key='$patient_key'";
$result_select = mysqli_query($conn, $sql_select);

if (mysqli_num_rows($result_select) > 0) {
    $row = mysqli_fetch_assoc($result_select);
    
    // Vérification des données POST et mise à jour des valeurs
    $age = isset($post["age"]) ? $post["age"] : $row["age"];
    $wikness = isset($post["wikness"]) ? $post["wikness"] : $row["wikness"];
    $allergies = isset($post["allergies"]) ? $post["allergies"] : $row["allergies"];
    $medkits = isset($post["medkits"]) ? $post["medkits"] : $row["medkits"];
    $temperature = isset($post["temperature"]) ? $post["temperature"] : $row["temperature"];
    $weight = isset($post["weight"]) ? $post["weight"] : $row["weight"];
    $respiration = isset($post["respiration"]) ? $post["respiration"] : $row["respiration"];
    $symptoms = isset($post["symptoms"]) ? $post["symptoms"] : $row["symptoms"];
    $diagnostic = isset($post["diagnostic"]) ? $post["diagnostic"] : $row["diagnostic"];
    $tension = isset($post["tension"]) ? $post["tension"] : $row["tension"];
    $pulse = isset($post["pulse"]) ? $post["pulse"] : $row["pulse"];
    $arrangement = isset($post["arrangement"]) ? $post["arrangement"] : $row["arrangement"];
    $observation = isset($post["observation"]) ? $post["observation"] : $row["observation"];
    
    // Requête SQL UPDATE
    $sql_update = "UPDATE diagnostics SET age='$age', wikness='$wikness', allergies='$allergies', medkits='$medkits', temperature='$temperature', weight='$weight', respiration='$respiration', symptoms='$symptoms', diagnostic='$diagnostic', tension='$tension', pulse='$pulse', arrangement='$arrangement', observation='$observation' WHERE patient_key='$patient_key'";
    
    if (mysqli_query($conn, $sql_update)) {
        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'message' => "Update succesfelly"
        ]);
            exit ;
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'fail',
            'data' => "Update failed"]);
            exit ;
    }
} else {
    http_response_code(400);
        echo json_encode([
            'code' => 'fail',
            'data' => "utilisateur n'existe pas "]);
            exit ;
}
