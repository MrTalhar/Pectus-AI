import '../models/exercise_model.dart';

final List<Exercise> dummyExercises = [

  // ══════════════════════════════════════════════════════
  // BREATHING  (7 exercises)
  // ══════════════════════════════════════════════════════

  Exercise(
    id: 'b1',
    title: 'Vacuum Breathing',
    description: 'Deep breathing exercise to expand the rib cage and strengthen the diaphragm.',
    instructions:
        '1. Stand or sit straight.\n2. Exhale completely.\n3. Pull your belly button in and up.\n4. Hold for 10–15 seconds.\n5. Release and inhale deeply.\n6. Repeat 10 times.',
    benefits: 'Improves chest expansion and trains core muscles to hold the ribs in a better position.',
    durationSeconds: 180,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'b2',
    title: 'Belly Breathing',
    description: 'Diaphragmatic breathing to activate the lower lungs and improve oxygen intake.',
    instructions:
        '1. Lie on your back with knees bent.\n2. Place one hand on chest, one on belly.\n3. Inhale slowly through the nose — belly rises, chest stays still.\n4. Exhale slowly through pursed lips.\n5. Repeat for 5 minutes.',
    benefits: 'Strengthens the diaphragm, reduces chest tightness, and promotes relaxation of accessory breathing muscles.',
    durationSeconds: 300,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'b3',
    title: 'Box Breathing',
    description: 'Structured 4-count breath pattern to control breathing rhythm and build lung capacity.',
    instructions:
        '1. Sit upright.\n2. Inhale for 4 counts.\n3. Hold for 4 counts.\n4. Exhale for 4 counts.\n5. Hold empty for 4 counts.\n6. Repeat 8–10 cycles.',
    benefits: 'Calms the nervous system, improves breath control, and expands thoracic volume over time.',
    durationSeconds: 240,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'b4',
    title: 'Balloon Blowing',
    description: 'Blow up a balloon to create resistance against exhalation and strengthen respiratory muscles.',
    instructions:
        '1. Take a deep breath through the nose.\n2. Place a balloon at your mouth.\n3. Blow steadily until fully inflated.\n4. Pinch the balloon and rest 10 seconds.\n5. Repeat 5–8 times.',
    benefits: 'Creates positive expiratory pressure that helps expand the chest wall from within and strengthens breathing muscles.',
    durationSeconds: 180,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'b5',
    title: 'Pursed Lip Breathing',
    description: 'Slow, controlled breathing technique that slows the breathing rate and improves gas exchange.',
    instructions:
        '1. Relax your neck and shoulders.\n2. Inhale slowly through the nose for 2 counts.\n3. Purse your lips as if blowing out a candle.\n4. Exhale slowly through pursed lips for 4 counts.\n5. Repeat for 3–5 minutes.',
    benefits: 'Slows breathing, reduces shortness of breath during exercise, and keeps airways open longer.',
    durationSeconds: 240,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'b6',
    title: 'Rib Expansion Breathing',
    description: 'Lateral breathing to consciously direct air into the sides and back of the ribcage.',
    instructions:
        '1. Place hands on the sides of your lower ribs.\n2. Breathe in deeply, trying to push your hands outward with your ribs.\n3. Hold for 3 seconds at the top.\n4. Exhale fully.\n5. Do 3 sets of 10 breaths.',
    benefits: 'Directly targets the costal cartilage stiffness common in Pectus Excavatum, improving lateral chest expansion.',
    durationSeconds: 180,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 'b7',
    title: 'Stacked Breathing',
    description: 'Advanced breathing technique that maximally fills the lungs in multiple stages.',
    instructions:
        '1. Exhale completely.\n2. Take a small sip of air and hold.\n3. Take another sip and hold again.\n4. Keep adding sips until lungs are full (4–5 sips).\n5. Hold at max capacity for 5 seconds.\n6. Exhale slowly.\n7. Repeat 6 times.',
    benefits: 'Maximally stretches the rib cage and builds significant respiratory muscle strength.',
    durationSeconds: 240,
    category: ExerciseCategory.breathing,
    difficulty: ExerciseDifficulty.hard,
  ),

  // ══════════════════════════════════════════════════════
  // FLEXIBILITY  (8 exercises)
  // ══════════════════════════════════════════════════════

  Exercise(
    id: 'f1',
    title: 'Doorway Stretch',
    description: 'Stretches the chest muscles and helps correct forward shoulder posture.',
    instructions:
        '1. Stand in a doorway.\n2. Place forearms on the doorframe at a 90-degree angle.\n3. Lean forward gently until you feel a stretch in your chest.\n4. Hold 30 seconds.\n5. Repeat 3 times.',
    benefits: 'Opens up the chest, reduces tightness in pectoralis major/minor, and improves overall posture.',
    durationSeconds: 90,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/1271-Uto7l43.gif',
  ),
  Exercise(
    id: 'f2',
    title: 'Cat-Cow Stretch',
    description: 'Spinal mobility exercise to loosen the thoracic spine.',
    instructions:
        '1. Start on hands and knees.\n2. Inhale and arch your back, dropping belly (Cow).\n3. Exhale and round your spine upward (Cat).\n4. Repeat smoothly for 12 reps.',
    benefits: 'Improves thoracic mobility which is crucial for overall chest expansion and posture.',
    durationSeconds: 90,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'f3',
    title: 'Thread the Needle',
    description: 'A thoracic rotation stretch to open the upper back and chest.',
    instructions:
        '1. Start on hands and knees.\n2. Slide right arm under the left arm along the floor.\n3. Let the right shoulder drop to the floor.\n4. Hold 30 seconds.\n5. Return and switch sides.\n6. Repeat 3 times per side.',
    benefits: 'Loosens thoracic rotation, reduces upper back stiffness, and opens the chest from the back.',
    durationSeconds: 120,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'f4',
    title: 'Pec Minor Stretch',
    description: 'Targeted stretch for the small chest muscle that pulls shoulders forward.',
    instructions:
        '1. Clasp hands behind your back.\n2. Gently squeeze shoulder blades together.\n3. Raise clasped hands slightly while pushing chest forward.\n4. Hold 20–30 seconds.\n5. Repeat 4 times.',
    benefits: 'Directly releases pectoralis minor tightness — a key contributor to the forward posture seen in Pectus Excavatum.',
    durationSeconds: 120,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'f5',
    title: 'Seated Thoracic Extension',
    description: 'Open the mid-back while seated over a chair back to reverse the hunching posture.',
    instructions:
        '1. Sit in a chair with a firm back.\n2. Clasp hands behind your head.\n3. Gently arch backward over the top edge of the chair.\n4. Hold 10 seconds.\n5. Return upright.\n6. Repeat 8 times, moving slightly higher each rep.',
    benefits: 'Targets thoracic kyphosis — the rounded upper back that worsens Pectus appearance — without needing any equipment.',
    durationSeconds: 120,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'f6',
    title: 'Chest Opener with Towel',
    description: 'Use a rolled towel or yoga strap to open the chest in multiple arm positions.',
    instructions:
        '1. Hold a rolled towel/strap with both hands, wide grip.\n2. Keeping arms straight, slowly lift the strap from in front up and over behind you.\n3. Go as far as comfortable.\n4. Bring back to the front.\n5. Repeat 10 times, narrowing grip each set.',
    benefits: 'Mobilises the shoulder joints and pectorals through a full range, counteracting the collapsed chest posture.',
    durationSeconds: 180,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 'f7',
    title: 'Lateral Rib Stretch',
    description: 'Side-bending stretch to open the intercostal spaces between the ribs.',
    instructions:
        '1. Stand with feet shoulder-width apart.\n2. Raise the right arm overhead.\n3. Lean slowly to the left, reaching up and over.\n4. Hold for 30 seconds, breathing into the right ribs.\n5. Switch sides.\n6. Repeat 3 times per side.',
    benefits: 'Stretches intercostal muscles between ribs, reducing the tightness that can restrict chest expansion in PE.',
    durationSeconds: 120,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/0002-Hy9D21L.gif',
  ),
  Exercise(
    id: 'f8',
    title: 'Child\'s Pose with Arm Extension',
    description: 'Deep stretch combining spine elongation with thoracic opening.',
    instructions:
        '1. Kneel and sit back toward heels.\n2. Extend arms forward on the floor as far as possible.\n3. Let your chest sink toward the floor.\n4. Hold for 45 seconds.\n5. Walk hands to the right, hold 20 sec; then left, hold 20 sec.',
    benefits: 'Gently decompresses the thoracic spine and stretches the entire anterior chest wall simultaneously.',
    durationSeconds: 120,
    category: ExerciseCategory.flexibility,
    difficulty: ExerciseDifficulty.easy,
  ),

  // ══════════════════════════════════════════════════════
  // POSTURE  (8 exercises)
  // ══════════════════════════════════════════════════════

  Exercise(
    id: 'p1',
    title: 'Wall Angels',
    description: 'Excellent for upper back strength and posture correction.',
    instructions:
        '1. Stand with back flat against a wall.\n2. Bring arms to 90 degrees against the wall.\n3. Slowly slide arms up and down while keeping contact.\n4. Perform 15 repetitions.',
    benefits: 'Activates lower traps and rhomboids, combats rounded shoulders associated with Pectus.',
    durationSeconds: 120,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 'p2',
    title: 'Scapular Squeezes',
    description: 'Simple but powerful exercise to retract and depress the shoulder blades.',
    instructions:
        '1. Sit or stand tall.\n2. Pull shoulder blades together and slightly down.\n3. Hold for 5 seconds.\n4. Release fully.\n5. Repeat 15–20 reps.',
    benefits: 'Activates rhomboids and mid-trapezius, directly counteracting forward shoulder posture common with Pectus.',
    durationSeconds: 90,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/1018-trmte8s.gif',
  ),
  Exercise(
    id: 'p3',
    title: 'Prone Y-T-W',
    description: 'Three-position back exercise targeting the full shoulder stabiliser complex.',
    instructions:
        '1. Lie face down on a mat, arms extended.\n2. Raise arms into a Y shape, hold 2 sec (5 reps).\n3. Move to T shape with thumbs up, hold 2 sec (5 reps).\n4. Bend elbows to W shape, hold 2 sec (5 reps).\n5. Rest and repeat 3 rounds.',
    benefits: 'Strengthens lower traps, serratus anterior, and rotator cuff — correcting spinal curvature that accompanies Pectus.',
    durationSeconds: 180,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 'p4',
    title: 'Foam Roller Thoracic Extension',
    description: 'Opens the mid-back over a foam roller to reverse hunched posture.',
    instructions:
        '1. Place foam roller perpendicular to spine at mid-back.\n2. Support head with hands behind neck.\n3. Gently arch backwards over the roller.\n4. Hold each segment 20–30 seconds.\n5. Slowly roll up and down from shoulder blades to lower thoracic.',
    benefits: 'Directly mobilises the thoracic kyphosis that worsens Pectus appearance and breathing capacity.',
    durationSeconds: 180,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/2208-isofgzg.gif',
  ),
  Exercise(
    id: 'p5',
    title: 'Chin Tucks',
    description: 'Corrects forward head posture that often accompanies Pectus Excavatum.',
    instructions:
        '1. Sit or stand tall.\n2. Gently pull your chin straight back (not down).\n3. You should feel a slight stretch at the base of skull.\n4. Hold 5 seconds.\n5. Release.\n6. Repeat 15–20 times.\n7. Perform against a wall for feedback.',
    benefits: 'Realigns the cervical spine and head, restoring the natural posture chain that improves overall chest alignment.',
    durationSeconds: 90,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/1403-x2chWLO.gif',
  ),
  Exercise(
    id: 'p6',
    title: 'Dead Hang',
    description: 'Hang from a pull-up bar to decompress the spine and open the chest.',
    instructions:
        '1. Grip a pull-up bar with hands slightly wider than shoulders.\n2. Hang freely, letting gravity stretch your spine.\n3. Breathe deeply — try to expand the chest with each inhale.\n4. Hold for 20–30 seconds.\n5. Rest and repeat 3–5 times.',
    benefits: 'Decompresses thoracic vertebrae and passively stretches the entire anterior chest wall in a way no other exercise can.',
    durationSeconds: 150,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/2333-PXTIwgu.gif',
  ),
  Exercise(
    id: 'p7',
    title: 'Shoulder Blade Circles',
    description: 'Controlled rotational movement to mobilise the scapulae and loosen the upper back.',
    instructions:
        '1. Stand or sit with good posture.\n2. Roll both shoulders slowly forward in large circles (10 reps).\n3. Then roll backwards in large circles (10 reps).\n4. Exaggerate the backward roll, pulling blades down and together.\n5. Do 3 sets.',
    benefits: 'Improves scapular mobility, warms up the upper back muscles, and promotes better resting shoulder position.',
    durationSeconds: 90,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.easy,
  ),
  Exercise(
    id: 'p8',
    title: 'Thoracic Rotation',
    description: 'Seated rotation to improve the rotational mobility of the thoracic spine.',
    instructions:
        '1. Sit on a chair sideways or on the floor cross-legged.\n2. Place hands behind head, elbows wide.\n3. Rotate your upper body to the right as far as comfortable.\n4. Hold 2 seconds.\n5. Return to centre, then rotate left.\n6. Do 10 reps each side.',
    benefits: 'Unlocks thoracic rotation stiffness that develops from Pectus posture, allowing better lung expansion and freer movement.',
    durationSeconds: 120,
    category: ExerciseCategory.posture,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/0985-225x2Vd.gif',
  ),

  // ══════════════════════════════════════════════════════
  // STRENGTH  (9 exercises)
  // ══════════════════════════════════════════════════════

  Exercise(
    id: 's1',
    title: 'Dumbbell Pullover',
    description: 'A classic exercise for expanding the rib cage and building the chest.',
    instructions:
        '1. Lie upper back across a flat bench.\n2. Hold a dumbbell with both hands above chest.\n3. Lower weight behind your head keeping arms slightly bent.\n4. Pull it back to start position.\n5. 3 sets of 12 reps.',
    benefits: 'Stretches the rib cage, builds the serratus anterior and chest muscles.',
    durationSeconds: 300,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/1316-cA9FuWG.gif',
  ),
  Exercise(
    id: 's2',
    title: 'Wide-Grip Push-ups',
    description: 'A push-up variation with hands placed wider to target the outer chest and serratus.',
    instructions:
        '1. Hands wider than shoulder width, fingers pointing slightly outward.\n2. Lower chest toward floor, elbows at 45 degrees.\n3. Push back up powerfully.\n4. Squeeze chest at the top.\n5. 3 sets of 10–15 reps.',
    benefits: 'Builds pectoral and serratus anterior strength which supports the chest wall from the outside.',
    durationSeconds: 240,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/1311-JmMVpR3.gif',
  ),
  Exercise(
    id: 's3',
    title: 'Serratus Anterior Punches',
    description: 'Isolation movement that activates the serratus anterior — key muscle for chest wall support.',
    instructions:
        '1. Lie on back holding light dumbbells straight up.\n2. Without moving the rest of your body, punch the weights toward the ceiling.\n3. Feel the shoulder blades spread apart (protraction).\n4. Lower back slowly.\n5. 3 sets of 15 reps.',
    benefits: 'The serratus anterior holds the rib cage outward. Strengthening it is one of the most targeted exercises for Pectus Excavatum.',
    durationSeconds: 180,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 's4',
    title: 'Resistance Band Rows',
    description: 'Pulling exercise to strengthen the mid and upper back to offset chest concavity.',
    instructions:
        '1. Anchor band at chest height.\n2. Stand or sit, grip band with both hands, arms extended.\n3. Pull elbows back, squeezing shoulder blades together.\n4. Hold 1 second at peak contraction.\n5. Return slowly.\n6. 3 sets of 15 reps.',
    benefits: 'Balances push–pull strength and corrects the rounded upper back posture common in Pectus patients.',
    durationSeconds: 240,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/0027-eZyBC3j.gif',
  ),
  Exercise(
    id: 's5',
    title: 'Dumbbell Chest Flyes',
    description: 'Open-chain chest exercise that stretches and strengthens the pectoral muscles.',
    instructions:
        '1. Lie on a flat bench with dumbbells directly above chest.\n2. Slightly bend elbows and lower arms wide to the sides.\n3. Stop when you feel a good chest stretch.\n4. Squeeze chest to bring arms back up.\n5. 3 sets of 12 reps with light-moderate weight.',
    benefits: 'Stretches and builds the pectoralis major, helping fill out the chest depression and improve its visual appearance.',
    durationSeconds: 300,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/0308-yz9nUhF.gif',
  ),
  Exercise(
    id: 's6',
    title: 'Face Pulls',
    description: 'Cable or band exercise targeting rear deltoids and external rotators to correct posture.',
    instructions:
        '1. Anchor a band at face height.\n2. Hold both ends with an overhand grip.\n3. Pull the band toward your face, separating hands as you pull.\n4. Elbows should end higher than hands.\n5. Squeeze and hold 1 second.\n6. 3 sets of 15–20 reps.',
    benefits: 'Directly targets rear deltoids and external rotators — muscles that pull the shoulders back and open the chest.',
    durationSeconds: 240,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/1022-tc5dYrf.gif',
  ),
  Exercise(
    id: 's7',
    title: 'Incline Dumbbell Press',
    description: 'Upper chest press to develop the clavicular head of the pectorals.',
    instructions:
        '1. Set a bench to 30–45 degrees.\n2. Lie back holding dumbbells at chest level, elbows at 45 degrees.\n3. Press dumbbells up and slightly together at the top.\n4. Lower slowly to the start.\n5. 3 sets of 10 reps.',
    benefits: 'Builds upper chest thickness, which has the most visual impact on the appearance of a Pectus chest.',
    durationSeconds: 300,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.hard,
    gifFile: 'videos/0047-3TZduzM.gif',
  ),
  Exercise(
    id: 's8',
    title: 'Pull-ups',
    description: 'Compound pulling exercise that builds the back and opens the chest under load.',
    instructions:
        '1. Hang from a bar with overhand grip, slightly wider than shoulders.\n2. Pull yourself up until chin clears the bar.\n3. Lower slowly (3 seconds down).\n4. Avoid swinging.\n5. 3 sets to controlled failure (or use a band for assistance).',
    benefits: 'Builds lat and upper back strength which pulls the shoulders back and improves the posture that accompanies PE.',
    durationSeconds: 240,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.hard,
    gifFile: 'videos/0017-kiJ4Z2K.gif',
  ),
  Exercise(
    id: 's9',
    title: 'Knee Push-ups',
    description: 'Beginner-friendly push-up variation to build foundational chest strength.',
    instructions:
        '1. Start in a modified push-up position on your knees.\n2. Hands slightly wider than shoulder width.\n3. Lower your chest to the floor in a controlled manner.\n4. Push back up, fully extending arms.\n5. 3 sets of 12–15 reps.',
    benefits: 'Builds initial chest and serratus strength for those new to exercise, with less strain than full push-ups.',
    durationSeconds: 180,
    category: ExerciseCategory.strength,
    difficulty: ExerciseDifficulty.easy,
    gifFile: 'videos/3211-ZOuKWir.gif',
  ),

  // ══════════════════════════════════════════════════════
  // CARDIO  (4 exercises)
  // ══════════════════════════════════════════════════════

  Exercise(
    id: 'c1',
    title: 'Swimming Drills',
    description: 'Swimming is the single best whole-body exercise recommended for Pectus Excavatum.',
    instructions:
        '1. Warm up with 2 laps of easy freestyle.\n2. Perform 4 laps of backstroke — focus on the opening of the chest with each stroke.\n3. Perform 4 laps of breaststroke — the arm pull-back specifically opens the chest.\n4. Cool down with 2 laps easy.\n5. Focus on deep breathing throughout.',
    benefits: 'Combines full chest expansion breathing, postural muscles, and cardiovascular exercise. The buoyancy also removes spinal compression.',
    durationSeconds: 1800,
    category: ExerciseCategory.cardio,
    difficulty: ExerciseDifficulty.medium,
    gifFile: 'videos/3433-SP3hUez.gif',
  ),
  Exercise(
    id: 'c2',
    title: 'Jump Rope',
    description: 'Cardiovascular exercise that promotes upright posture and rhythmic deep breathing.',
    instructions:
        '1. Stand tall with shoulders back and chest open.\n2. Jump rope at a moderate pace for 1 minute.\n3. Rest 30 seconds.\n4. Repeat for 5–8 rounds.\n5. Focus on keeping the chest open and breathing deeply through the nose.',
    benefits: 'Builds cardiovascular endurance and naturally encourages the upright posture and deep breathing that Pectus patients need to practise.',
    durationSeconds: 600,
    category: ExerciseCategory.cardio,
    difficulty: ExerciseDifficulty.medium,
  ),
  Exercise(
    id: 'c3',
    title: 'Mountain Climbers',
    description: 'High-intensity core and cardio exercise that strengthens the muscles around the chest.',
    instructions:
        '1. Start in a high plank position, wrists under shoulders.\n2. Drive right knee toward chest.\n3. Quickly switch — left knee forward, right leg back.\n4. Maintain a fast but controlled alternating pace.\n5. Perform 4 sets of 30 seconds with 20 seconds rest.',
    benefits: 'Builds core strength that stabilises the chest wall, and the plank position also activates the serratus anterior.',
    durationSeconds: 300,
    category: ExerciseCategory.cardio,
    difficulty: ExerciseDifficulty.hard,
    gifFile: 'videos/0630-RJgzwny.gif',
  ),
  Exercise(
    id: 'c4',
    title: 'Brisk Walking with Posture Focus',
    description: 'A walking routine specifically focused on maintaining correct posture throughout.',
    instructions:
        '1. Walk at a brisk pace.\n2. Keep shoulders back and down, chest open.\n3. Breathe in for 4 steps, out for 4 steps.\n4. Every 5 minutes, consciously check: chin tucked, shoulders back, core light.\n5. Walk for 20–30 minutes.',
    benefits: 'Builds postural endurance — the ability to hold correct chest position throughout the day — which is as important as targeted exercises.',
    durationSeconds: 1200,
    category: ExerciseCategory.cardio,
    difficulty: ExerciseDifficulty.easy,
  ),
];
