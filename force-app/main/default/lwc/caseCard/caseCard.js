import { LightningElement, api } from 'lwc';

export default class CaseCard extends LightningElement {
    @api caseRecord; 

    handleBack() {
        
        this.dispatchEvent(new CustomEvent('back', {
            bubbles: true,
            composed: true
        }));
    }
}
