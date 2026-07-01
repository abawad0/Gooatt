import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../models/models.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double _taste = 8, _value = 7, _cleanliness = 8, _speed = 7;
  final _commentController = TextEditingController();
  final _nameController = TextEditingController();
  int _wordCount = 0;
  bool _submitted = false;

  double get _totalScore => Rating.calculateScore(
    taste: _taste, value: _value, cleanliness: _cleanliness, speed: _speed,
  );

  void _onCommentChanged(String text) {
    final words = text.trim().isEmpty ? <String>[] : text.trim().split(RegExp(r'\s+'));
    if (words.length > 150) {
      final limited = words.take(150).join(' ');
      _commentController.value = TextEditingValue(
        text: limited,
        selection: TextSelection.collapsed(offset: limited.length),
      );
      setState(() => _wordCount = 150);
    } else {
      setState(() => _wordCount = words.length);
    }
  }

  void _submit() {
    // TODO: send to Supabase
    // await supabase.from('ratings').insert({
    //   'dish_name': _nameController.text,
    //   'taste': _taste, 'value': _value,
    //   'cleanliness': _cleanliness, 'speed': _speed,
    //   'score': _totalScore, 'comment': _commentController.text,
    // });
    setState(() => _submitted = true);
  }

  void _reset() {
    setState(() {
      _submitted = false;
      _nameController.clear();
      _commentController.clear();
      _wordCount = 0;
      _taste = 8; _value = 7; _cleanliness = 8; _speed = 7;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إضافة تقييم', style: TextStyle(fontFamily: 'Tajawal')),
          actions: [
            if (!_submitted)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Center(
                  child: TextButton(
                    onPressed: _submit,
                    child: const Text('نشر', style: TextStyle(color: Colors.white, fontFamily: 'Tajawal')),
                  ),
                ),
              ),
          ],
        ),
        body: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _card([
          const Text('اسم الطبق والمطعم', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 13, fontFamily: 'Tajawal'),
            decoration: InputDecoration(
              hintText: 'مثال: شاورما دجاج — مطعم الأمير',
              hintStyle: const TextStyle(fontSize: 12, fontFamily: 'Tajawal'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFEAE8E4))),
            ),
          ),
        ]),
        const SizedBox(height: 12),
        _card([
          const Text('تقييم الطبق', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
          const SizedBox(height: 8),
          _ratingSlider('الطعم', _taste, (v) => setState(() => _taste = v)),
          _ratingSlider('السعر مقابل الجودة', _value, (v) => setState(() => _value = v)),
          _ratingSlider('النظافة', _cleanliness, (v) => setState(() => _cleanliness = v)),
          _ratingSlider('سرعة الخدمة', _speed, (v) => setState(() => _speed = v)),
          const Divider(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('التقييم الإجمالي', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            Text(_totalScore.toStringAsFixed(1), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
          ]),
        ]),
        const SizedBox(height: 12),
        _card([
          Row(children: [
            const Text('مراجعة مختصرة', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            const SizedBox(width: 4),
            const Text('(150 كلمة كحد أقصى)', style: TextStyle(fontSize: 10, color: Color(0xFFAAAAAA), fontFamily: 'Tajawal')),
          ]),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            onChanged: _onCommentChanged,
            maxLines: 3,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 13, fontFamily: 'Tajawal'),
            decoration: InputDecoration(
              hintText: 'شاركنا تجربتك مع هذا الطبق...',
              hintStyle: const TextStyle(fontSize: 12, fontFamily: 'Tajawal'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFEAE8E4))),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$_wordCount / 150 كلمة', style: const TextStyle(fontSize: 11, color: Color(0xFFAAAAAA), fontFamily: 'Tajawal')),
          ),
        ]),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {/* TODO: image picker */},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFCCCCCC), width: 0.5, style: BorderStyle.solid),
            ),
            child: const Column(children: [
              Icon(Icons.camera_alt_outlined, size: 24, color: Color(0xFFAAAAAA)),
              SizedBox(height: 6),
              Text('أضف صورة للطبق', style: TextStyle(fontSize: 12, color: Color(0xFF888888), fontFamily: 'Tajawal')),
            ]),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submit,
            child: const Text('نشر التقييم', style: TextStyle(fontFamily: 'Tajawal')),
          ),
        ),
      ]),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🎉', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          const Text('تم نشر تقييمك!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Tajawal')),
          const SizedBox(height: 8),
          const Text('شكراً على مساهمتك في مجتمع قوّت', style: TextStyle(fontSize: 13, color: Color(0xFF888888), fontFamily: 'Tajawal')),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: QawwatTheme.amber, borderRadius: BorderRadius.circular(12), border: Border.all(color: QawwatTheme.amberBorder, width: 0.5)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('🏅 إنجاز جديد!', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF633806), fontFamily: 'Tajawal')),
              SizedBox(height: 4),
              Text('وصلت إلى 48 تقييم — أنت الآن في أفضل 5% من المقيّمين', style: TextStyle(fontSize: 11, color: Color(0xFF854F0B), fontFamily: 'Tajawal')),
            ]),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _reset,
              child: const Text('إضافة تقييم آخر', style: TextStyle(fontFamily: 'Tajawal')),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _card(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFEAE8E4), width: 0.5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _ratingSlider(String label, double value, ValueChanged<double> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(fontSize: 12, fontFamily: 'Tajawal')),
          Text(value.toInt().toString(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFC84B2F), fontFamily: 'Tajawal')),
        ]),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(activeTrackColor: QawwatTheme.primary, thumbColor: QawwatTheme.primary, inactiveTrackColor: const Color(0xFFEAE8E4)),
          child: Slider(value: value, min: 1, max: 10, divisions: 9, onChanged: onChanged),
        ),
      ]),
    );
  }
}
