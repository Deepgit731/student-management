public class ExceptionHandel {
    public static void excpt(String Name){
        list<Account> a = new list<Account>();
        try{            
                Account at = new Account();
                at.Name = Name;
                a.add(at);
                insert a;
        }catch(Exception e){
            system.debug(e);
        }
    }
    

}