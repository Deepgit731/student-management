import { LightningElement, track, wire } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import PRIORITY_FIELD from '@salesforce/schema/Case.Priority';
import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';

export default class CaseFilter extends LightningElement {
    @track status = '';
    @track priority = '';
    @track origin = '';

    statusOptions = [];
    priorityOptions = [];
    originOptions = [];

    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: STATUS_FIELD })
    wiredStatusPicklist(value) { this.setOptions(value, 'statusOptions'); }

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: PRIORITY_FIELD })
    wiredPriorityPicklist(value) { this.setOptions(value, 'priorityOptions'); }

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: ORIGIN_FIELD })
    wiredOriginPicklist(value) { this.setOptions(value, 'originOptions'); }

    setOptions({ data }, target) {
        if (data) {
            this[target] = [{ label: 'All', value: '' }, ...data.values];
        }
    }

    handleChange(event) {
        this[event.target.name] = event.target.value;
        this.dispatchEvent(new CustomEvent('filterschange', {
            detail: {
                status: this.status,
                priority: this.priority,
                origin: this.origin
            }
        }));
    }
}
