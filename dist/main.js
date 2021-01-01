// Helper functions.
const createDateString = () => {
  return `The current date and time is ${new Date().toString()} ==> click me to update <==`;
};

// Create the nodes.
const footer = document.createElement("footer");
const small = document.createElement("small");

// Update the node's props.
small.innerHTML = createDateString();
small.onclick = () => {
  small.innerHTML = createDateString();
};

// Build the tree.
footer.appendChild(small);
document.body.appendChild(footer);
