<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
$post = json_decode(file_get_contents('php://input'), true);
include_once "../library/function.php";



    if (isset($post["specialite"]) ) //specialite
    {
        $specialite = $post["specialite"];
        $selectarray=array();
        array_push($selectarray,$specialite);
        $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
        FROM users
        INNER JOIN doctors
        on users.cle=doctors.cle
        WHERE doctors.specialite = ?";
        $result=dbExec($sql,$selectarray);
        $arrJson = array();
    if ($result->rowCount() > 0) {
        $arrJson  = $result->fetchall();
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
    }     
    elseif (isset($post["rating"]))//rate 
    {
        $rating = $post["rating"];
        $selectarray=array();
        array_push($selectarray,$rating);
        $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
        FROM users
        INNER JOIN doctors
        on users.cle=doctors.cle
        WHERE doctors.rate > ?";
        $result=dbExec($sql,$selectarray);
        $arrJson = array();
    if ($result->rowCount() > 0) {
        $arrJson  = $result->fetchall();
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
    }  
    elseif (isset($post["etablisement"]))//etablisement
    {
        $etablisement = $post["etablisement"];
        $selectarray=array();
        array_push($selectarray,$etablisement);
        $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
        FROM users
        INNER JOIN doctors
        on users.cle=doctors.cle
        WHERE users.address = ?";
        $result=dbExec($sql,$selectarray);
        $arrJson = array();
    if ($result->rowCount() > 0) {
        $arrJson  = $result->fetchall();
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
    }
    elseif(isset($post["specialite"])&&isset($post["rate"]))//rate && specialite
    {
        $specialite=$post["specialite"];
        $rate = $post["rate"];
        $selectarray=array();
        array_push($selectarray,$rate);
        array_push($selectarray,$specialite);
        $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
        FROM users
        INNER JOIN doctors
        on users.cle=doctors.cle
        WHERE doctors.specialite = ? and doctors.rate > ?";
        $result=dbExec($sql,$selectarray);
        $arrJson = array();
    if ($result->rowCount() > 0) {
        $arrJson  = $result->fetchall();
        $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    } else {
        //bad request
        $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
        echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
    }
    }
    elseif(isset($post["etablisement"]) && isset($post["specialite"]))//etablisement && specialite
    {
        {
            $specialite=$post["specialite"];
            $etablisement = $post["etablisement"];
            $selectarray=array();
            array_push($selectarray,$etablisement);
            array_push($selectarray,$specialite);
            $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
            FROM users
            INNER JOIN doctors
            on users.cle=doctors.cle
            WHERE doctors.specialite = ? and Users.address = ?";
            $result=dbExec($sql,$selectarray);
            $arrJson = array();
        if ($result->rowCount() > 0) {
            $arrJson  = $result->fetchall();
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
        }
    }
    elseif(isset($post["rate"])&& isset($post["etablisement"])) //etablisement && rate
    {
        {
            $rating=$post["rate"];
            $etablisement = $post["etablisement"];
            $selectarray=array();
            array_push($selectarray,$rating);
            array_push($selectarray,$etablisement);
            $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
            FROM users
            INNER JOIN doctors
            on users.cle=doctors.cle
            WHERE doctors.rate = > ? and Users.address = ?";
            $result=dbExec($sql,$selectarray);
            $arrJson = array();
        if ($result->rowCount() > 0) {
            $arrJson  = $result->fetchall();
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
        } 
    }
    elseif(isset($post["specialite"])&&isset($post["rate"])&&isset($post["etablisement"]))//etablisement && rate && specialite
    {
        {
            $specialite=$post["specialite"];
            $rating=$post["rate"];
            $etablisement = $post["etablisement"];
            $selectarray=array();
            array_push($selectarray,$rating);
            array_push($selectarray,$etablisement);
            array_push($selectarray,$specialite);
            $sql = "SELECT users.nomPrenom,users.address,users.email,users.address,users.numero,doctors.rate,doctors.NombreAvis,doctors.specialite
            FROM users
            INNER JOIN doctors
            on users.cle=doctors.cle
            WHERE doctors.specialite and doctors.rate = > ? and Users.address = ?";
            $result=dbExec($sql,$selectarray);
            $arrJson = array();
        if ($result->rowCount() > 0) {
            $arrJson  = $result->fetchall();
            $resJson = array("result" => "success", "code" => "200", "message" => $arrJson);
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        } else {
            //bad request
            $resJson = array("result" => "empty", "code" => "400", "message" => "Aucun redez-vous");
            echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
        }
        } 

    } 
       else 
    {
        $privilege="medecin";
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "promedplus";
$conn = mysqli_connect($servername, $username, $password, $dbname);
if (!$conn) {
    die("Connexion échouée : " . mysqli_connect_error());
}
$selectArray=array();
array_push($selectArray,$privilege);
$sql="select nomprenom,email,address,numero from users where privilege = ?";
$result=dbExec($sql,$selectArray);
$arrJson = array();
if ($result->rowCount() > 0) {
    $arrJson  = $result->fetchall();
    http_response_code(200);
        echo json_encode([
            'code' => 'success',
            'data' => $arrJson]);
            exit ;
} else {    
    http_response_code(400);
        echo json_encode([
            'code' => 'faild',
            'data' => "eurror"]);
            exit ;
}
    }
    
?>