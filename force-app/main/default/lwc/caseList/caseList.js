import { LightningElement, api, track, wire } from 'lwc';
import getFilteredCases from '@salesforce/apex/CaseController.getFilteredCases';
import { refreshApex } from '@salesforce/apex';

export default class CaseList extends LightningElement {
    @api status = '';
    @api priority = '';
    @api origin = '';

    @track cases = [];
    @track error;
    @track selectedCase;

    wiredCasesResult;

    columns = [
        {
            label: 'Case Number',
            fieldName: 'caseLink',
            type: 'url',
            typeAttributes: {
                label: { fieldName: 'CaseNumber' },
                target: '_blank'
            }
        },
        { label: 'Subject', fieldName: 'Subject' },
        { label: 'Status', fieldName: 'Status' },
        { label: 'Priority', fieldName: 'Priority' },
        { label: 'Origin', fieldName: 'Origin' },
        {
            type: 'action',
            typeAttributes: {
                rowActions: [
                    { label: 'View', name: 'view' },
                    { label: 'Edit', name: 'edit' },
                    { label: 'Delete', name: 'delete' }
                ],
                menuAlignment: 'auto'
            }
        }
    ];

    @wire(getFilteredCases, { status: '$status', priority: '$priority', origin: '$origin' })
wiredCases(result) {
    this.wiredCasesResult = result;
    if (result.data) {
        this.cases = result.data.map(c => ({
            ...c,
            caseLink: `/lightning/r/Case/${c.Id}/view`
        }));
        this.error = undefined;
    } else if (result.error) {
        this.error = result.error;
        this.cases = [];
    }
}


    @api
    refreshCases() {
        if (this.wiredCasesResult) {
            refreshApex(this.wiredCasesResult);
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'view') {
            this.selectedCase = row; 
        } else {
            this.dispatchEvent(new CustomEvent(actionName, {
                detail: { caseId: row.Id },
                bubbles: true,
                composed: true
            }));
        }
    }

    closeModal() {
        this.selectedCase = null;
    }
}
