import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serategna_freelance_app/bloc/job_bloc/bloc.dart';
import 'package:serategna_freelance_app/data_layer/models/job_model.dart';

class AddJob extends StatefulWidget {
  final bool createJob;
  final JobModel job;

  const AddJob({Key key, this.createJob, this.job}) : super(key: key);

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> jobData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 100, 30, 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    widget.createJob ? 'Add a new Job' : 'Edit Job',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.title,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Title' : null,
                    onSaved: (val) =>
                        setState(() => jobData["_currentName"] = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: this.widget.createJob
                        ? ""
                        : this.widget.job.salary.toString(),
                    decoration: InputDecoration(
                      labelText: 'Salary',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Salary' : null,
                    onSaved: (val) =>
                        setState(() => jobData["_currentPrice"] = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.company,
                    decoration: InputDecoration(
                      labelText: 'Company',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Company Name' : null,
                    onSaved: (val) => setState(
                        () => jobData["_currentManufacturingCompany"] = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.position,
                    decoration: InputDecoration(
                      labelText: 'Position',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please Enter Position' : null,
                    onSaved: (val) =>
                        setState(() => jobData["_currentBrand"] = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: this.widget.createJob
                        ? ""
                        : this.widget.job.description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Description' : null,
                    onSaved: (val) =>
                        setState(() => jobData["_currentDescription"] = val),
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue:
                        this.widget.createJob ? "" : this.widget.job.jobType,
                    decoration: InputDecoration(
                      labelText: 'Job Type',
                      focusColor: Color(0xff4064f3),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Theme.of(context).cardTheme.color,
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter Job Type' : null,
                    onSaved: (val) => setState(
                        () => jobData["_currentManufactringDate"] = val),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      color: Colors.green[400],
                      child: Text(
                        this.widget.createJob ? 'Post' : 'update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          JobModel jobModel = JobModel(
                              id: this.widget.job != null
                                  ? this.widget.job.id
                                  : "",
                              title: jobData["_currentName"],
                              description: jobData["_currentDescription"],
                              salary: int.parse(jobData["_currentPrice"]),
                              company: jobData["_currentManufacturingCompany"],
                              jobType: jobData["_currentManufactringDate"],
                              position: jobData["_currentBrand"]);
                          JobEvent event = this.widget.createJob
                              ? JobCreate(jobModel)
                              : JobUpdate(jobModel);
                          BlocProvider.of<JobBloc>(context).add(event);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
