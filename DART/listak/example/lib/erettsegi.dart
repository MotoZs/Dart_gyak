import 'package:flutter/material.dart';

class ErettsegTorezslap extends StatefulWidget {
  const ErettsegTorezslap({Key? key}) : super(key: key);

  @override
  State<ErettsegTorezslap> createState() => _ErettsegTorezsolapState();
}

class _ErettsegTorezsolapState extends State<ErettsegTorezslap> {
  final _formKey = GlobalKey<FormState>();

  // Személyes adatok
  String nev = '';
  String szuletesiDatum = '';
  String szuletesiHely = '';
  String anyjaneve = '';
  String azonosito = '';

  // Érettségi adatok
  String sorszam = '';
  String vizsgazasHelye = '';
  String vizsgazasEve = '';

  // Nyelvvizsga
  String nyelvvizsga = 'Nem';
  String nyelvvizsgaNyelv = '';
  String nyelvvizsgaSzint = '';
  String nyelvvizsgaSzervezet = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Érettségi Törzslap'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FEJLÉC
              Center(
                child: Column(
                  children: const [
                    Text(
                      'ÉRETTSÉGI TÖRZSLAP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Magyar Köztársaság', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // SZEMÉLYES ADATOK SZEKCIÓ
              _buildSectionTitle('I. SZEMÉLYES ADATOK'),
              const SizedBox(height: 15),

              TextFormField(
                decoration: _buildInputDecoration('Teljes név'),
                onChanged: (value) => setState(() => nev = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration(
                  'Születési dátum (YYYY.MM.DD)',
                ),
                onChanged: (value) => setState(() => szuletesiDatum = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration('Születési hely'),
                onChanged: (value) => setState(() => szuletesiHely = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration('Anyja neve'),
                onChanged: (value) => setState(() => anyjaneve = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration('Azonosító szám'),
                onChanged: (value) => setState(() => azonosito = value),
              ),
              const SizedBox(height: 30),

              // ÉRETTSÉGI ADATOK SZEKCIÓ
              _buildSectionTitle('II. ÉRETTSÉGI VIZSGA ADATAI'),
              const SizedBox(height: 15),

              TextFormField(
                decoration: _buildInputDecoration('Sorszám'),
                onChanged: (value) => setState(() => sorszam = value),
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration('Vizsgazás helye'),
                onChanged: (value) => setState(() => vizsgazasHelye = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                decoration: _buildInputDecoration('Vizsgazás éve'),
                onChanged: (value) => setState(() => vizsgazasEve = value),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Kötelező mező!' : null,
              ),
              const SizedBox(height: 30),

              // NYELVVIZSGA SZEKCIÓ
              _buildSectionTitle('III. NYELVVIZSGA'),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      'Nyelvvizsga:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Nem',
                            groupValue: nyelvvizsga,
                            onChanged: (value) {
                              setState(() => nyelvvizsga = value ?? 'Nem');
                            },
                          ),
                          const Text('Nem'),
                          const SizedBox(width: 20),
                          Radio<String>(
                            value: 'Igen',
                            groupValue: nyelvvizsga,
                            onChanged: (value) {
                              setState(() => nyelvvizsga = value ?? 'Igen');
                            },
                          ),
                          const Text('Igen'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              if (nyelvvizsga == 'Igen') ...[
                TextFormField(
                  decoration: _buildInputDecoration('Vizsga nyelve'),
                  onChanged: (value) =>
                      setState(() => nyelvvizsgaNyelv = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Kötelező mező!' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Szint (pl. B1, B2, C1)'),
                  onChanged: (value) =>
                      setState(() => nyelvvizsgaSzint = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Kötelező mező!' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  decoration: _buildInputDecoration('Vizsga szervezete'),
                  onChanged: (value) =>
                      setState(() => nyelvvizsgaSzervezet = value),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Kötelező mező!' : null,
                ),
                const SizedBox(height: 20),
              ],

              const SizedBox(height: 30),

              // GOMBOK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.save),
                    label: const Text('Mentés'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Törlés'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ÖSSZEFOGLALÁS
              if (nev.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adatok összefoglalása:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildSummaryRow('Név:', nev),
                      _buildSummaryRow('Születési dátum:', szuletesiDatum),
                      _buildSummaryRow('Születési hely:', szuletesiHely),
                      _buildSummaryRow('Vizsgazás helye:', vizsgazasHelye),
                      _buildSummaryRow('Vizsgazás éve:', vizsgazasEve),
                      if (nyelvvizsga == 'Igen') ...[
                        const SizedBox(height: 10),
                        const Divider(),
                        const Text(
                          'Nyelvvizsga:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        _buildSummaryRow('Nyelv:', nyelvvizsgaNyelv),
                        _buildSummaryRow('Szint:', nyelvvizsgaSzint),
                        _buildSummaryRow('Szervezet:', nyelvvizsgaSzervezet),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adatok sikeresen mentve!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      nev = '';
      szuletesiDatum = '';
      szuletesiHely = '';
      anyjaneve = '';
      azonosito = '';
      sorszam = '';
      vizsgazasHelye = '';
      vizsgazasEve = '';
      nyelvvizsga = 'Nem';
      nyelvvizsgaNyelv = '';
      nyelvvizsgaSzint = '';
      nyelvvizsgaSzervezet = '';
    });
  }
}
