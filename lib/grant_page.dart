import 'package:flutter/material.dart';

class GrantApplicationPage extends StatefulWidget {
  const GrantApplicationPage({Key? key}) : super(key: key);

  @override
  State<GrantApplicationPage> createState() => _GrantApplicationPageState();
}

class _GrantApplicationPageState extends State<GrantApplicationPage> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  final TextEditingController UntCntroller = TextEditingController();

  String gender = 'Male';
  bool isLoading = false;
  String? predictionResult; // for showing backend response

  Future<void> _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        predictionResult = null;
      });

      // === PLACEHOLDER: Backend connection starts here ===
      // TODO: Replace this with your backend API call.
      // Example (using http package):
      //
      // final response = await http.post(
      //   Uri.parse("https://your-backend-api.com/predict"),
      //   headers: {"Content-Type": "application/json"},
      //   body: jsonEncode({
      //     "name": nameController.text,
      //     "age": int.parse(ageController.text),
      //     "gender": gender,
      //     "gpa": double.parse(gpaController.text),
      //     "income": double.parse(UNTCOntroller.text),
      //   }),
      // );
      //
      // final result = jsonDecode(response.body);
      // predictionResult = result["prediction"];
      //
      // Simulate backend delay and result
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        predictionResult = "✅ Congratulations! Your grant is approved!";
        // You could also have "❌ Unfortunately, not approved this time."
        isLoading = false;
      });
      // === PLACEHOLDER: Backend connection ends here ===
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text(
          "Grant Predictor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF006B5E),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Enter Applicant Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF006B5E),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter your name" : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        labelText: "Age",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter your age";
                        if (int.tryParse(value) == null) {
                          return "Enter a valid number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.wc),
                      ),
                      value: gender,
                      onChanged: (value) => setState(() => gender = value!),
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(value: "Female", child: Text("Female")),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: gpaController,
                      decoration: const InputDecoration(
                        labelText: "GPA (0.0 - 4.0)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter your GPA";
                        final gpa = double.tryParse(value);
                        if (gpa == null || gpa < 0 || gpa > 4.0) {
                          return "Enter a valid GPA (0.0 - 4.0)";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: UntCntroller,
                      decoration: const InputDecoration(
                        labelText: "UNT Score (0 - 140)",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) return "Please enter your UNT score";
                        final unt = int.tryParse(value);
                        if (unt == null || unt < 0 || unt > 140) {
                          return "Enter a valid UNT score (0 - 140)";
                        }
                        return null;
                      }
                          
                    ),
                    const SizedBox(height: 25),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF006B5E),
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.analytics),
                            label: const Text(
                              "Check Grant Eligibility",
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            onPressed: _submitApplication,
                          ),
                    const SizedBox(height: 20),
                    if (predictionResult != null)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: predictionResult!.contains("✅")
                              ? Colors.green.shade50
                              : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          predictionResult!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: predictionResult!.contains("✅")
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
