import { LightningElement, api, wire } from 'lwc';
import getOpportunities from '@salesforce/apex/OpportunitiesController.getOpportunities';

export default class GetOpportunities extends LightningElement {
    @api recordId;
    showList = false;
    @wire(getOpportunities, { accId: '$recordId' })
    opportunities;
    handleShowOpportunities() {
        this.showList = true;
    }
}
