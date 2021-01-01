// Helper functions.
const createDateString = () => {
  return `The current date and time is ${new Date().toString()} ==> click me to update <==`;
};

// Create the nodes.
const footer = document.createElement("footer");
const small = document.createElement("small");
const madeWithLove = document.createElement("small");

// Update the node's props.
small.innerHTML = createDateString();
small.onclick = () => {
  small.innerHTML = createDateString();
};

madeWithLove.innerHTML = `<br>Made with 💜 and <a href="https://github.com/penguingovernor/penguingovernor.github.io">open-source</a>`;

// Build the tree.
footer.appendChild(small);
footer.appendChild(madeWithLove);
document.body.appendChild(footer);
