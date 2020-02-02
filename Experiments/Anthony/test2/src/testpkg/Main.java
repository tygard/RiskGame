package testpkg;

import java.io.*;
import java.util.LinkedList;

public class Main {

    public static void main(String[] args) throws IOException {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        int M = Integer.parseInt(reader.readLine());
        LinkedList<Integer> lList = new LinkedList<>();
        int num = 0;
        System.out.println(M);
        int item = reader.read();
        while (item != -1){
            item = reader.read();
            if ((char)item == 32){
                lList.add(num);
                num = 0;
            } else {
                num = num * 10 + item;
            }
        }

        try {
            System.out.println(lList.get(lList.size() - M));
        } catch (IndexOutOfBoundsException e){
            System.out.println("NIL");
        }
    }
}
