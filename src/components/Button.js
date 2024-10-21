import React from 'react';
import './Button.css'; // Optional: If you have specific styles for the Button

const Button = ({ label, onClick }) => {
  return (
    <button className="calculator-button" onClick={() => onClick(label)}>
      {label}
    </button>
  );
};

export default Button;
