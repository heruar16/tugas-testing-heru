<?php
$koneksi = mysqli_connect("localhost", "root", "", "login_ci");

if (!$koneksi) {
    die("Koneksi database gagal: " . mysqli_connect_error());
}
?>
