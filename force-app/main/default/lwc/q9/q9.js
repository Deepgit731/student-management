import { LightningElement, api, wire } from 'lwc';
import updateAccountIndustry from '@salesforce/apex/AccountUpdater.updateAccountIndustry';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class UpdateIndustryFromRecord extends LightningElement {
    @api recordId;
    newIndustry = '';
    industryOptions = [];

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT }) objectInfo;

    @wire(getPicklistValues, {
        recordTypeId: '$objectInfo.data.defaultRecordTypeId',
        fieldApiName: INDUSTRY_FIELD
    })
    wiredPicklist({ data, error }) {
        if (data) this.industryOptions = data.values;
        else if (error) this.showToast('Error', 'Failed to load picklist.', 'error');
    }

    handleIndustryChange(e) {
        this.newIndustry = e.detail.value;
    }

    handleUpdateClick() {
        if (!this.newIndustry) return this.showToast('Error', 'Select a valid Industry.', 'error');

        updateAccountIndustry({ accountId: this.recordId, newIndustry: this.newIndustry })
            .then(() => this.showToast('Success', 'Industry updated!', 'success'))
            .catch(e => this.showToast('Error', e.body.message, 'error'));
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}
