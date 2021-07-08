<?php


if(isset($_POST['username']) && isset($_POST['password'])) {

    require 'db_connect.php';

    $query = "SELECT USERID FROM `users` WHERE USERNAME='" . $_POST['username'] . "'";
    $result = mysqli_query($connect, $query);

    if ($row = mysqli_fetch_array($result)) {


        $query = "SELECT USERID FROM `users` WHERE USERNAME='" . $_POST['username'] . "' and PASSWORD='" .sha1( $_POST["password"]) . "';";
        $result = mysqli_query($connect, $query);


        if ($row = mysqli_fetch_array($result)) {
            $data["done"] = 1;
            session_start();
            $_SESSION["uid"] = $row["USERID"];

        }else{
            $data["done"] = -2;
            $data["message"]="Invalid Password";
        }

    }else {
        $data["done"] = -1;
        $data["message"]="Invalid Username";
    }
}else{
    $data["done"] = 0;
}
echo json_encode($data);
