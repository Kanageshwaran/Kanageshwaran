// Initial test alert to confirm JS works
// alert("Hello, world!");  // now moved inside the function

// Bigger button function
function makeBigger() {
    alert("Hello, world!");  // required confirmation alert
    let textArea = document.getElementById("textArea");
    textArea.style.fontSize = "24pt";
}

// Radio button style toggler
function applyStyle() {
    let textArea = document.getElementById("textArea");
    let fancy = document.getElementById("fancy");

    if (fancy.checked) {
        alert("FancyShmancy selected!");
        textArea.style.fontWeight = "bold";
        textArea.style.color = "blue";
        textArea.style.textDecoration = "underline";
    } else {
        alert("BoringBetty selected!");
        textArea.style.fontWeight = "normal";
        textArea.style.color = "black";
        textArea.style.textDecoration = "none";
    }
}

// Moo button
function moo() {
    let textArea = document.getElementById("textArea");

    // Uppercase text
    let text = textArea.value.toUpperCase();

    // Split text into sentences
    let parts = text.split(".");

    // Add "-Moo" to the last word in each sentence
    for (let i = 0; i < parts.length - 1; i++) {
        parts[i] = parts[i].trim() + "-Moo";
    }

    // Rejoin sentences with periods
    textArea.value = parts.join(". ");
}
