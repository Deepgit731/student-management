import { LightningElement } from 'lwc';

export default class Q1 extends LightningElement {
    label = "Click Me";
    handleClick(){
        this.label ="Clicked";

    }
}