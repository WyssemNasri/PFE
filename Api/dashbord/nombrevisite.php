<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";

// Create an array of all months
$allMonths = array(
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
);

if (isset($post["nomPrenom"])) {
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    if (!$conn) {
        die("Connexion échouée : " . mysqli_connect_error());
    }
    $cle = $post["nomPrenom"];
    $sql = "SELECT * FROM users WHERE nomPrenom = '$cle'";
    $result = mysqli_query($conn, $sql);
    $arrJson = array();
    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $nomprenom = $row['nomPrenom'];
        $sql1 = "SELECT 
            MONTH(date) AS month,
            COUNT(*) AS visit_count
            FROM appointments 
            WHERE patient_name = '$nomprenom' AND status = 'accepted' AND date < CURDATE()
            GROUP BY month";

        $result = mysqli_query($conn, $sql1);

        // Initialize an array to store the counts for all months with initial value 0
        $monthlyCounts = array_fill_keys($allMonths, 0);

        if (mysqli_num_rows($result) > 0) {
            while ($row1 = mysqli_fetch_assoc($result)) {
                $monthNum = $row1['month'];
                $monthName = date("F", mktime(0, 0, 0, $monthNum, 1));
                $monthlyCounts[$monthName] = $row1['visit_count'];
            }
        }

        http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $monthlyCounts
        ]);
        exit;
    } else {
        http_response_code(400);
        echo json_encode([
            'code' => 'fail',
            'data' => "Insérer un nomPrenom valide"
        ]);
        exit;
    }
}
?>
