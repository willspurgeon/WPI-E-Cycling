<?php
 $to = "will@spurgeonworld.com";
 $subject = "A message from the WPI app";
 $body = $_POST["message"];
 if (mail($to, $subject, $body)) {
   echo("<p>Message successfully sent!</p>");
  } else {
   echo("<p>Message delivery failed...</p>");
  }
 ?>