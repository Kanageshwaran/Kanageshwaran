/*
  Encrypt-It!
 */

(function() {
  "use strict";

  /*
  The starting point of the program.
  Sets up event listeners when the window loads.
   */
  window.addEventListener("load", init);

  /*
    Initializes event handlers for the "Encrypt It!" and "Reset" buttons.
    Logs a message to confirm that JS is running.
   */
  function init() {
    console.log("Window loaded!"); // Part I

    // Add event listeners for both buttons
    document.getElementById("encrypt-it").addEventListener("click", handleClick);
    document.getElementById("reset").addEventListener("click", handleReset);
  }

  /*
    Handles click of the Encrypt button.
    Retrieves the text, encrypts using shift cipher, and displays the result.
   */
  function handleClick() {
    console.log("Button clicked!"); // Part II

    let input = document.getElementById("input-text").value;
    let encrypted = shiftCipher(input);
    document.getElementById("result").textContent = encrypted;
  }

  /*
    Handles click of the Reset button.
    Clears the input textarea and the result field.
   */
  function handleReset() {
    document.getElementById("input-text").value = "";
    document.getElementById("result").textContent = "";
  }

  /*
   Returns a shift-cipher encrypted version of the text.
   Each letter shifts forward by 1 alphabetically (z → a).
   */
  function shiftCipher(text) {
    text = text.toLowerCase();
    let result = "";

    for (let i = 0; i < text.length; i++) {
      let ch = text[i];

      if (ch < 'a' || ch > 'z') {
        // Non-letter: keep the same
        result += ch;
      } else if (ch === 'z') {
        result += 'a';
      } else {
        let letterCode = text.charCodeAt(i);
        let shifted = String.fromCharCode(letterCode + 1);
        result += shifted;
      }
    }
    return result;
  }

})();
