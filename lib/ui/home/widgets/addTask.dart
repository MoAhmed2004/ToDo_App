import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/style/DialogUtils.dart';
import 'package:todo/style/reusable_components/customFormField.dart';
import 'package:todo/style/reusable_components/validation.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}


class _AddTaskState extends State<AddTask> {
  late TextEditingController TitleController;
  late TextEditingController DescriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TitleController = TextEditingController();
    DescriptionController = TextEditingController();
  }
  @override
  dispose(){
    super.dispose();
    TitleController.dispose();
    DescriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: 22,
        right: 22,
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 22
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add Task",style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),),
            SizedBox(
              height: height * 0.05,
            ),
            Customformfield(
                label: "Enter Task",
                keyboard: TextInputType.text,
                controller: TitleController,
                validator: (value){
                  if(value ==null || value.isEmpty){
                    return "Please Enter Task";
                  }
                  return null;
                },),
            SizedBox(
              height: height * 0.02,
            ),
            Customformfield(
                label: "Enter Task Description",
                maxlines: null,
                keyboard: TextInputType.multiline,
                controller: DescriptionController,
                validator:(value) {
                  Validation.nameValidator(
                      value,
                      "Please Enter Task Description",
                      );
                  return null;
                }),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: () {
                showTaskDate();
              },
              child: Text(selectedDate==null
                  ?"Date"
                :DateFormat.yMMMd().format(selectedDate!),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14
              ),),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
  DateTime? selectedDate;
  addTask(){
    if(formKey.currentState!.validate()){
      if(selectedDate!=null){

      }else{
        DialogUtils.showToast("Please Select Date");
      }
    }
  }
  showTaskDate()async{
    selectedDate = await showDatePicker(
      initialDate: selectedDate,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    setState(() {

    });
  }
}
