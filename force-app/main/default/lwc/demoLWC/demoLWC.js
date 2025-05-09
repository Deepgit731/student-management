import { LightningElement } from 'lwc';

export default class DemoLWC extends LightningElement {
    firstNumber = 0;
    secondNumber = 0;
    result = 0;

    handleFirstNumberChange(event) {
        this.firstNumber = parseFloat(event.target.value);
    }

    handleSecondNumberChange(event) {
        this.secondNumber = parseFloat(event.target.value);
    }

    handleAdd() {
        this.result = this.firstNumber + this.secondNumber;
    }

    handleSubtract() {
        this.result = this.firstNumber - this.secondNumber;
    }

    handleMultiply() {
        this.result = this.firstNumber * this.secondNumber;
    }

    handleDivide() {
        if (this.secondNumber !== 0) {
            this.result = this.firstNumber / this.secondNumber;
        } else {
            this.result = 'Error (Divide by 0)';
        }
    }
}