"""TensorFlow Lite Python Interface: Custom check."""
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import io
import numpy as np
import six

from tensorflow.lite.python import interpreter as interpreter_wrapper
from tensorflow.python.framework import test_util
from tensorflow.python.platform import resource_loader
from tensorflow.python.platform import test


class InterpreterTest(test_util.TensorFlowTestCase):

  def testFloat(self):
    interpreter = interpreter_wrapper.Interpreter(
        model_path=resource_loader.get_path_to_datafile(
            'testdata/maxpool2d.tflite'))
    interpreter.allocate_tensors()

    input_details = interpreter.get_input_details()
    self.assertEqual(1, len(input_details))
    self.assertEqual('t_0', input_details[0]['name'])
    self.assertEqual(np.float32, input_details[0]['dtype'])
    self.assertTrue(([1, 1, 3, 3] == input_details[0]['shape']).all())
    self.assertEqual((0.0, 0), input_details[0]['quantization'])

    output_details = interpreter.get_output_details()
    self.assertEqual(1, len(output_details))
    self.assertEqual('t_3', output_details[0]['name'])
    self.assertEqual(np.float32, output_details[0]['dtype'])
    self.assertTrue(([1, 1, 2, 2] == output_details[0]['shape']).all())
    self.assertEqual((0.0, 0), output_details[0]['quantization'])

    test_input = np.array([[[[1, 2, 3], [4, 5, 6], [7, 8, 9]]]], dtype=np.float32)
    expected_output = np.array([[5, 6], [8, 9]], dtype=np.float32)
    interpreter.set_tensor(input_details[0]['index'], test_input)
    interpreter.invoke()

    output_data = interpreter.get_tensor(output_details[0]['index'])
    self.assertTrue((expected_output == output_data).all())

if __name__ == '__main__':
  test.main()
