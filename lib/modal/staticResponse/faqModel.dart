class FaqModel {
  final String question;
  final String answer;
  FaqModel(this.question, this.answer);
}

class DemoData {
  static final List<FaqModel> faqs = [
    FaqModel("How can I return an item?",
        '''To return/exchange your order, follow these simple steps:
1. Go to My orders
2. Choose the item you wish to return or exchange
3. Fill in the details
4. Choose Request Return.'''),
    FaqModel(
        '''How can I use a new email address to log in to my V2 Care account?''',
        '''To return/exchange your order, follow these simple steps:
1. Go to My orders
2. Choose the item you wish to return or exchange
3. Fill in the details
4. Choose Request Return.'''),
    FaqModel("What is the replacement process for orders?",
        '''To return/exchange your order, follow these simple steps:
1. Go to My orders
2. Choose the item you wish to return or exchange
3. Fill in the details
4. Choose Request Return.'''),
    FaqModel("How do I get invoices for my previous orders?",
        '''To return/exchange your order, follow these simple steps:
1. Go to My orders
2. Choose the item you wish to return or exchange
3. Fill in the details
4. Choose Request Return.'''),
  ];
}