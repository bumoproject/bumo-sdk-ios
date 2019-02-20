/*
	dxl is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	dxl is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with dxl.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifdef OS_LINUX
#include <sys/prctl.h>
#elif defined OS_MAC
#include <semaphore.h>
#endif

#include "strings.h"
#include "thread.h"

const pthread_t utils::Thread::INVALID_HANDLE = (pthread_t)-1;

#ifdef WIN32
DWORD WINAPI utils::Thread::threadProc(LPVOID param)
#else
void *utils::Thread::threadProc(void *param)
#endif
{
	Thread *this_thread = reinterpret_cast<Thread *>(param);

	this_thread->Run();
	this_thread->thread_id_ = 0;

#ifdef WIN32
	CloseHandle(this_thread->handle_);
#endif // WIN32

	this_thread->handle_ = INVALID_HANDLE;
	this_thread->running_ = false;
#ifdef WIN32
	_endthreadex(0);
	return 0;
#else
	return NULL;
#endif
}

bool utils::Thread::Start(std::string name) {
	name_ = name;
	if (running_) {
		return false;
	}

	bool result = false;
	enabled_ = true;
	running_ = true;
	int ret = 0;
#ifdef WIN32
	handle_ = ::CreateThread(NULL, 0, (LPTHREAD_START_ROUTINE)threadProc, (LPVOID)this, 0, (LPDWORD)&thread_id_);
	result = (NULL != handle_);

#elif defined OS_LINUX
	pthread_attr_t object_attr;
	pthread_attr_init(&object_attr);
	pthread_attr_setdetachstate(&object_attr, PTHREAD_CREATE_DETACHED);

   	//checking and keep min stack 2 Mb on linux
	size_t stacksize = 0;
	ret = pthread_attr_getstacksize(&object_attr, &stacksize);
	if(ret != 0) {
		printf("get stacksize error!:%d\n", (int)stacksize);
		pthread_attr_destroy(&object_attr);
		return false;
	}

	if(stacksize <= 2 * 1024 * 1024)
	{
		printf("linux default pthread statck size:%d\n", (int)stacksize);
		stacksize = 2 * 1024 * 1024;
		printf("set pthread statck size:%d\n", (int)stacksize);

		ret = pthread_attr_setstacksize(&object_attr, stacksize);
		if (ret != 0) {
			printf("set stacksize error!:%d\n", (int)stacksize);
			pthread_attr_destroy(&object_attr);
			return false;
		}
	}


	ret = pthread_create(&handle_, &object_attr, threadProc, (void *)this);
	result = (0 == ret);
	thread_id_ = handle_;
	pthread_attr_destroy(&object_attr);
##else
	pthread_attr_t object_attr;
	pthread_attr_init(&object_attr);
	pthread_attr_setdetachstate(&object_attr, PTHREAD_CREATE_DETACHED);

	//warning mac default set 512Kb, we need set larger
	size_t stacksize = 0;
	ret = pthread_attr_getstacksize(&object_attr, &stacksize);
	if(ret != 0) {
		printf("get stacksize error!:%d\n", (int)stacksize);
		pthread_attr_destroy(&object_attr);
		return false;
	}

	printf("mac default pthread statck size:%d\n", (int)stacksize);
	if(stacksize <= 2 * 1024 * 1024)
	{
		stacksize = 2 * 1024 * 1024;
		printf("set pthread statck size:%d\n", (int)stacksize);

		ret = pthread_attr_setstacksize(&object_attr, stacksize);
		if (ret != 0) {
			printf("set stacksize error!:%d\n", (int)stacksize);
			pthread_attr_destroy(&object_attr);
			return false;
		}
	}

	ret = pthread_create(&handle_, &object_attr, threadProc, (void *)this);
	result = (0 == ret);
	thread_id_ = (size_t)handle_;
	pthread_attr_destroy(&object_attr);
#endif
	if (!result) {
		// restore _beginthread or pthread_create's error
		utils::set_error_code(ret);

		handle_ = Thread::INVALID_HANDLE;
		enabled_ = false;
		running_ = false;
	}
	return result;
}


bool utils::Thread::Stop() {
	if (!IsObjectValid()) {
		return false;
	}

	enabled_ = false;
	return true;
}


bool utils::Thread::Terminate() {
	if (!IsObjectValid()) {
		return false;
	}

	bool result = true;
#ifdef WIN32
	if (0 == ::TerminateThread(handle_, 0)) {
		result = false;
	}
#elif defined OS_LINUX
	if (0 != pthread_cancel(thread_id_)) {
		result = false;
	}
##else
	if (0 != pthread_cancel((pthread_t)thread_id_)) {
		result = false;
	}
#endif

	enabled_ = false;
	return result;
}

bool utils::Thread::JoinWithStop() {
	if (!IsObjectValid()) {
		return true;
	}

	enabled_ = false;
	while (running_) {
		utils::Sleep(10);
	}

	return true;
}

void utils::Thread::Run() {
	assert(target_ != NULL);

	SetCurrentThreadName(name_);

	target_->Run(this);
}

bool utils::Thread::SetCurrentThreadName(std::string name) {
#ifdef WIN32
	//not supported
	return true;
#elif defined OS_LINUX
	return 0 == prctl(PR_SET_NAME, name.c_str(), 0, 0, 0);
##else
	pthread_setname_np(name.c_str());
#endif //WIN32
    return true;
}

size_t utils::Thread::current_thread_id() {
#ifdef WIN32
	return (size_t)::GetCurrentThreadId();
#else
	return (size_t)pthread_self();
#endif
}

utils::Mutex::Mutex()
	: thread_id_(0) {
#ifdef WIN32
	InitializeCriticalSection(&mutex_);
#else
	pthread_mutexattr_t mattr;
	pthread_mutexattr_init(&mattr);
	pthread_mutexattr_settype(&mattr, PTHREAD_MUTEX_RECURSIVE);
	pthread_mutex_init(&mutex_, &mattr);
	pthread_mutexattr_destroy(&mattr);
#endif
}

utils::Mutex::~Mutex() {
#ifdef WIN32
	DeleteCriticalSection(&mutex_);
#else
	pthread_mutex_destroy(&mutex_);
#endif
}

void utils::Mutex::Lock() {
#ifdef WIN32
	EnterCriticalSection(&mutex_);
#ifdef _DEBUG
	thread_id_ = static_cast<uint32_t>(GetCurrentThreadId());
#endif
#else
	pthread_mutex_lock(&mutex_);
#ifdef _DEBUG
	thread_id_ = static_cast<uint32_t>(pthread_self());
#endif
#endif
}

void utils::Mutex::Unlock() {
#ifdef _DEBUG
	thread_id_ = 0;
#endif
#ifdef WIN32
	LeaveCriticalSection(&mutex_);
#else
	pthread_mutex_unlock(&mutex_);
#endif
}

utils::ReadWriteLock::ReadWriteLock()
	: _reads(0) {}

utils::ReadWriteLock::~ReadWriteLock() {}

void utils::ReadWriteLock::ReadLock() {
	_enterLock.Lock();
	AtomicInc(&_reads);
	_enterLock.Unlock();
}

void utils::ReadWriteLock::ReadUnlock() {
	AtomicDec(&_reads);
}

void utils::ReadWriteLock::WriteLock() {
	_enterLock.Lock();
	while (_reads > 0) {
		Sleep(0);
	}
}

void utils::ReadWriteLock::WriteUnlock() {
	_enterLock.Unlock();
}
