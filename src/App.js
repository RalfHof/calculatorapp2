import React, { useState } from 'react';
import Display from './components/Display';
import Button from './components/Button';
import './App.css';

const App = () => {
  const [input, setInput] = useState('');

  const handleClick = (label) => {
    if (label === 'C') {
      setInput('');
    } else if (label === '=') {
      try {
        const expression = input.replace(/×/g, '*').replace(/÷/g, '/');
        // eslint-disable-next-line no-eval
        const result = eval(expression);
        setInput(result.toString());
      } catch {
        setInput('Error');
      }
    } else {
      setInput(input + label);
    }
  };

  const buttons = [
    '7', '8', '9', '÷',
    '4', '5', '6', '×',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
    'C'
  ];

  return (
      <div className="calculator">
      <p className="instance-ip">Instance IP: {window.location.hostname}</p>
      <Display value={input} />
      <div className="buttons">
        {buttons.map((btn, idx) => (
          <Button key={idx} label={btn} onClick={handleClick} />
        ))}
      </div>
    </div>
  );
};

export default App;

