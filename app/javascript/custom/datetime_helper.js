function setCurrentTime(fieldId) {
    var now = new Date();
    var year = now.getFullYear();
    var month = (now.getMonth() + 1).toString().padStart(2, '0');
    var day = now.getDate().toString().padStart(2, '0');
    var hours = now.getHours().toString().padStart(2, '0');
    var minutes = now.getMinutes().toString().padStart(2, '0');

    var formattedDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;
    document.getElementById(fieldId).value = formattedDateTime;
}