import 'dart:ffi';

void main(){
VendingMachine vendingMachine = VendingMachine();
vendingMachine.addItem(Item("Cola", 0.25), 12);
vendingMachine.selectItem("Cola");
vendingMachine.insertMoney(2);
vendingMachine.dispenseItem("Cola");
double change = vendingMachine.getChange();
  print('Your change is: ${change.toStringAsFixed(2)}');

}


class Item{
  Item(this.itemName, this.price);
  String itemName = "";
  double price= 0;

  String displayItem(){
  return "$itemName: ${price.toStringAsFixed(2)}";
}
}

class ItemStock{
Item item;
int stock;
ItemStock(this.item, this.stock);

bool isInStock(){
return stock>0;
}
void updatedStock(int newStock) {
    stock = newStock;
  }
}

class VendingMachine{
  List<ItemStock> items = [];
  double balance = 0;

void addItem(Item item, int stock){
items.add(ItemStock(item, stock));
}


void selectItem(String itemName){
  items.forEach((itemInStock){
    if(itemInStock.item.itemName == itemName){
      if(itemInStock.isInStock()){
        print("You selected: ${itemInStock.item.displayItem()}");
      } else {
        print("Looks like we're out of $itemName");
      } return;
    }
  });
}

void insertMoney(double money){
balance = balance + money;
print(balance);
}

void dispenseItem(String itemName) {
   items.forEach((itemInStock){
   if(itemInStock.item.itemName==itemName){
    if(itemInStock.isInStock()){
      if(balance >= itemInStock.item.price) {
        balance -= itemInStock.item.price;
        itemInStock.updatedStock(itemInStock.stock -1);
        print("Here's your ${itemInStock.item.itemName}, Enjoy!");
      } else {
        print("Looks like you don't have enough to purchase, $itemName");
      }
    }
   }
  });
  }

double getChange(){
  double temp = balance;
  return temp;
}
}



