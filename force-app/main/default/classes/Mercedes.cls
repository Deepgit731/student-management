public class Mercedes implements IVehicle{
     public void start(){
        System.debug('Start');
    }
    public void stop(){
        System.debug('stop');
    }
    public String changeGear(){
        System.debug('change gear');
        return '';
    }
    public Boolean openDoor(String doorType){
        return true;
    }

}